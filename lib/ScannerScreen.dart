import 'dart:math';

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
    _controller.dispose();
    super.dispose();
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
            bottom: 16.0, // Adjust the bottom position as needed
            left: 0,
            right: 0,
            child: Center(
                child: IconButton(
              onPressed: () async {
                try {
                  await _initializeControllerFuture;
                  final image = await _controller.takePicture();
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
              icon: Icon(
                Icons.lens_outlined,
                size: 96,
                color: Colors.white.withOpacity(0.8),
              ),
              padding: const EdgeInsets.all(12), // Adjust the padding as needed
              tooltip: 'Start scanning', // Add a tooltip if desired
            )),
          ),
        ],
      ),
    );
  }
}
