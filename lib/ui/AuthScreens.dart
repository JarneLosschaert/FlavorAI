import 'package:flutter/material.dart';

import 'auth_screens/login_page.dart';

class AuthScreens extends StatefulWidget {
  const AuthScreens({super.key});




  @override
  State<AuthScreens> createState() => _AuthScreensState();
}

class _AuthScreensState extends State<AuthScreens> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}