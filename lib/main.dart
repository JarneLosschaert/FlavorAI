import 'package:camera/camera.dart';
import 'package:flavor_ai_testing/UI/AppScreens.dart';
import 'package:flavor_ai_testing/UI/AuthScreens.dart';
import 'package:flavor_ai_testing/constants/colors.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  bool loggedIn = false; //temp

  void updateLoginStatus(bool status) {
    loggedIn = status;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flavor AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      routes: {
        '/auth': (context) => const AuthScreens(),
        '/app': (context) => const AppScreens()
      },
      initialRoute: loggedIn ? '/app' : '/auth',
    );
  }
}
