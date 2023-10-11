import 'package:camera/camera.dart';
import 'package:flavor_ai_testing/UI/AppScreens.dart';
import 'package:flavor_ai_testing/UI/AuthScreens.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, /*required this.camera*/});

  // final CameraDescription camera;

  final bool loggedIn = true; //temp

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flavor AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
