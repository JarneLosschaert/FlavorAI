import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'dart:ui' as ui;
import 'package:image/image.dart' as img;

import 'package:path_provider/path_provider.dart';

import 'package:camera/camera.dart';
import 'package:flavor_ai_testing/constants/colors.dart';
import 'package:flavor_ai_testing/logic/service.dart';
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
  List<String> _foundProductsPopup = [];
  List<String> _foundProducts = [];
  final Map<String, List<double>> _cropRectangleCoords = {
    "x": [0.1, 0.9],
    "y": [0.4, 0.55],
  };

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.veryHigh,
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

        final croppedImage = await _cropImage(image);

        debugPrint(
            'previewSize: ${_controller.value.previewSize!.width}x${_controller.value.previewSize!.height}');
        debugPrint('ScannerScreen._takePicture: ${image.path}');

        String responseBody =
            await Service.instance.fetchProductsFromImage(croppedImage);

        debugPrint('Response from image upload: $responseBody');

        Map<String, dynamic> responseMap = json.decode(responseBody);

        if (responseMap.containsKey("products")) {
          List<String> products = List<String>.from(responseMap["products"]);
          if (products.isNotEmpty) {
            setState(() {
              List<String> foundProductsFromCurrentScan = [];
              for (var p in products) {
                if (!_foundProducts.contains(p)) {
                  _foundProducts.add(p);
                  _foundProductsPopup.add(p);
                  foundProductsFromCurrentScan.add(p);
                }
              }

              // Automatically clear the found product name after a delay
              Future.delayed(const Duration(seconds: 3), () {
                setState(() {
                  _foundProductsPopup.removeWhere(
                      (elem) => foundProductsFromCurrentScan.contains(elem));
                });
              });
            });
          }
        } else {
          // Handle if the "products" key is missing or the response format is unexpected
        }
      } catch (e) {
        debugPrint(e.toString());
      } finally {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  Future<File> _cropImage(XFile image) async {
    final bytes = File(image.path).readAsBytesSync();
    final rawImage = img.decodeImage(bytes)!;

    double left = _cropRectangleCoords["x"]![0] * rawImage.width;
    double top = _cropRectangleCoords["y"]![0] * rawImage.height;
    double width = rawImage.width *
        (_cropRectangleCoords["x"]![1] - _cropRectangleCoords["x"]![0]);
    double height = rawImage.height *
        (_cropRectangleCoords["y"]![1] - _cropRectangleCoords["y"]![0]);

    debugPrint('left: $left, top: $top, width: $width, height: $height');

    final croppedImage = img.copyCrop(
      rawImage,
      left.toInt(),
      top.toInt(),
      width.toInt(),
      height.toInt(),
    );

    debugPrint('croppedImage: ${croppedImage.width}x${croppedImage.height}');

    final croppedBytes = Uint8List.fromList(img.encodePng(croppedImage));
    final croppedImageFile = await _saveImageToDisk(croppedBytes);

    return croppedImageFile;
  }

  Future<File> _saveImageToDisk(Uint8List croppedBytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/cropped_image.png';
    final File croppedImageFile = File(filePath);
    await croppedImageFile.writeAsBytes(croppedBytes);
    return croppedImageFile;
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
                return LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    double rectWidth = constraints.maxWidth *
                        (_cropRectangleCoords["x"]![1] -
                            _cropRectangleCoords["x"]![0]);
                    double rectHeight = constraints.maxHeight *
                        (_cropRectangleCoords["y"]![1] -
                            _cropRectangleCoords["y"]![0]);

                    debugPrint(
                        'layoutbuilder controller previewSize: ${_controller.value.previewSize!.width}x${_controller.value.previewSize!.height}');
                    debugPrint(
                        'constraints: ${constraints.maxWidth}x${constraints.maxHeight}');

                    return CameraPreview(_controller,
                        child: Positioned(
                          left: constraints.maxWidth *
                              _cropRectangleCoords["x"]![0],
                          top: constraints.maxHeight *
                              _cropRectangleCoords["y"]![0],
                          child: CustomPaint(
                            painter: RectanglePainter(
                              rectWidth: rectWidth,
                              rectHeight: rectHeight,
                            ),
                          ),
                        ));
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Positioned(
            bottom: 200,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: _foundProductsPopup.map((element) {
                  return Text(
                    element,
                    style: const TextStyle(
                      color: Colors.deepOrangeAccent,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: IconButton(
                // scanner button
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
          Positioned(
            bottom: 52,
            right: 16,
            child: ElevatedButton(
              // found products button
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  lightGreen,
                ),
              ),
              onPressed: () {}, // Add functionality here
              child: Text(
                'Items (${_foundProducts.length})',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RectanglePainter extends CustomPainter {
  final double rectWidth;
  final double rectHeight;

  RectanglePainter({
    required this.rectWidth,
    required this.rectHeight,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final Rect rect = Rect.fromLTRB(
      0,
      0,
      rectWidth,
      rectHeight,
    );

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
