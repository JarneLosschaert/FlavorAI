import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isScanning = false;
  Timer? _scanTimer;

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
      _takePicture();
    });
  }

  void _stopScanning() {
    _scanTimer?.cancel();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();

      debugPrint('ScannerScreen._takePicture: ${image.path}');

      // fetch to azure custom vision api
    } catch (e) {
      debugPrint(e.toString());
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
                  child:
                      CircularProgressIndicator(), // todo: should probably optimize this, maybe use a static controller so the camera doesn't have to load in every time
                );
              }
            },
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
