import 'package:flutter/material.dart';

import '../AppScreens.dart'; // Import your AppScreens widget

class LoginRegisterButton extends StatelessWidget {
  final String buttonText;

  const LoginRegisterButton({
    Key? key,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color accentColorLightGreen1 = Color(0xFF269826);
    return GestureDetector(
      onTap: () {

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AppScreens()),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(27),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(
              color: accentColorLightGreen1,
              fontWeight: FontWeight.w800,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
