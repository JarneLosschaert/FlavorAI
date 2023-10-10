import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flavor_ai_testing/constants/colors.dart';
import 'package:flavor_ai_testing/screens/homeScreen.dart';
import 'package:flavor_ai_testing/screens/scannerScreen.dart';
import 'package:flavor_ai_testing/screens/settingsScreen.dart';
import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      home: Main(camera: camera),
    );
  }
}

class Main extends StatefulWidget {
  const Main({super.key, required this.camera});

  final CameraDescription camera;

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _currentIndex = 0;
  late ScannerScreen _scannerScreen;
  late SettingsScreen _settingsScreen;

  @override
  void initState() {
    super.initState();
    _scannerScreen = ScannerScreen(camera: widget.camera);
    _settingsScreen = const SettingsScreen();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(onCardTapped: (int pageIndex) {
        setState(() {
          _currentIndex = pageIndex;
        });
      }),
      Builder(
        builder: (context) => _scannerScreen,
      ),
      Builder(
        builder: (context) => _settingsScreen,
      ),
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      backgroundColor: backgroundColor,
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          currentIndex:
              _currentIndex, // should probably replace this with a navigator widget
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          selectedItemColor: primaryColor,
          unselectedItemColor: secondaryColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
          iconSize: 40,
        ),
      )
    );
  }
}
