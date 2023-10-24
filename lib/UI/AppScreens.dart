import 'package:camera/camera.dart';
import 'package:flavor_ai_testing/UI/app_screens/HomeScreen.dart';
import 'package:flavor_ai_testing/UI/app_screens/RecipesScreen.dart';
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
    final List<Widget> pages = [
      HomeScreen(
        onCardTapped: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      _camera != null ? ScannerScreen(camera: _camera!) : Container(),
      const SettingsScreen(),
      const RecipesScreen()
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: const EdgeInsets.only(top: 32),
          child: pages[_currentIndex],
        ),
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
        child: Container(
          color: Colors.white,
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomNavigationBarItem(
                icon: Icons.home,
                index: 0,
                currentIndex: _currentIndex,
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              CustomNavigationBarItem(
                icon: Icons.camera_alt,
                index: 1,
                currentIndex: _currentIndex,
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              CustomNavigationBarItem(
                icon: Icons.settings,
                index: 2,
                currentIndex: _currentIndex,
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
            ],
          ),
        )
      ),
    );
  }
}

class CustomNavigationBarItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;

  const CustomNavigationBarItem({super.key,
    required this.icon,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == currentIndex;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? primaryColor : secondaryColor,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}