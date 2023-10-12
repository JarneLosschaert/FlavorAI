import 'package:flutter/material.dart';


class LoginRegisterButton extends StatelessWidget {
  final String buttonText;

  
  const LoginRegisterButton({
    Key? key,
    required this.buttonText, // Initialize the parameter in the constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color accentColorLightGreen1 = Color(0xFF269826);
    return Container(
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
    );
  }
}
