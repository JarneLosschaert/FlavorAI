import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flavor_ai_testing/HomeScreen.dart';
import 'package:flavor_ai_testing/ScannerScreen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.camera});

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flavor AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/scanner': (context) => ScannerScreen(camera: camera),
        '/settings': (context) => const Placeholder() // settings screen
      },
      initialRoute: '/home',
    );
  }
}
