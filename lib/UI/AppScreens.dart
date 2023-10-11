import 'package:camera/camera.dart';
import 'package:flavor_ai_testing/UI/app_screens/HomeScreen.dart';
import 'package:flavor_ai_testing/UI/app_screens/ScannerScreen.dart';
import 'package:flavor_ai_testing/UI/app_screens/SettingsScreen.dart';
import 'package:flavor_ai_testing/constants/colors.dart';
import 'package:flutter/material.dart';

class AppScreens extends StatefulWidget {
  const AppScreens({super.key});

  @override
  State<AppScreens> createState() => _AppScreensState();
}

class _AppScreensState extends State<AppScreens> {
  CameraDescription? _camera;
  int _currentIndex = 0;

  @override
  initState() {
    WidgetsFlutterBinding.ensureInitialized();
    initCamera();
    super.initState();
  }

  Future<void> initCamera() async {
    final camera = await availableCameras().then((value) => value.first);
    setState(() {
      _camera = camera;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(
        onCardTapped: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      _camera != null ? ScannerScreen(camera: _camera!) : Container(),
      const SettingsScreen(),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 100),
        child: _pages[_currentIndex],
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
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
      ),
    );
  }
}
