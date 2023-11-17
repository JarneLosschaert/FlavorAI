import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flavor_ai_testing/logic/services/recipes_service.dart';
import 'package:flutter/material.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key, required this.camera}) : super(key: key);

  final CameraDescription camera;

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isScanning = false;
  Timer? _scanTimer;
  bool _isProcessing = false;
  String _foundProductName = '';

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _stopScanning();
    _initializeControllerFuture.then((_) => _controller.dispose());
    super.dispose();
  }

  void _toggleScanning() {
    setState(() {
      _isScanning = !_isScanning;
      if (_isScanning) {
        _startScanning();
      } else {
        _stopScanning();
      }
    });
  }

  void _startScanning() {
    _scanTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!_isProcessing) {
        _takePicture();
      }
    });
  }

  void _stopScanning() {
    _scanTimer?.cancel();
  }

  Future<void> _takePicture() async {
    if (!_isProcessing) {
      setState(() {
        _isProcessing = true;
      });

      try {
        await _initializeControllerFuture;
        await _controller.setFlashMode(FlashMode.off);

        final XFile image = await _controller.takePicture();

        debugPrint('ScannerScreen._takePicture: ${image.path}');

        String responseBody =
            await ApiService.instance.fetchProductsFromImage(File(image.path));

        debugPrint('Response from image upload: $responseBody');

        setState(() {
          _foundProductName = responseBody;
        });

        // Automatically clear the found product name after a delay
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            _foundProductName = '';
          });
        });
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    debugPrint('ScannerScreen.build: ${widget.camera.toString()}');

    return Container(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                _foundProductName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: IconButton(
                onPressed: _toggleScanning,
                icon: Icon(
                  _isScanning
                      ? Icons.radio_button_checked_rounded
                      : Icons.circle_outlined,
                  size: 96,
                  color: _isScanning ? Colors.red : Colors.white,
                ),
                padding: const EdgeInsets.all(12),
                tooltip: _isScanning ? 'Stop scanning' : 'Start scanning',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
