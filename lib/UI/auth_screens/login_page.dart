
import 'package:flavor_ai_testing/UI/AppScreens.dart';
import 'package:flavor_ai_testing/UI/app_screens/HomeScreen.dart';
import 'package:flavor_ai_testing/UI/auth_screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login_register_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color myBackgroundColorLogin = Color(0xFF2F2F2F);
    const Color myBackgroundColorAccentLogin = Color(0xFF3F3F3F);
    const Color loginInputBackground = Color(0xFF545454);
    const Color accentColorDarkGreen1 = Color(0xFF296829);

    return Scaffold(
      backgroundColor: myBackgroundColorLogin,
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: MediaQuery.of(context).size.height * 0.6 - 37.5,
                child: RoundedContainer(),
              ),
              Positioned(
                right: 0,
                top: MediaQuery.of(context).size.height * 0.675 - 37.5,
                child: RoundedContainer2(),
              ),
              Positioned(
                left: 0,
                top: MediaQuery.of(context).size.height * 0.75 - 37.5,
                child: RoundedContainer(),
              ),
              Positioned(
                right: 0,
                top: MediaQuery.of(context).size.height * 0.825 - 37.5,
                child: RoundedContainer2(),
              ),
              SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      SvgPicture.asset(
                        'assets/images/flavorAI.svg',
                        width: 125.0,
                        height: 125.0,
                      ),
                      const SizedBox(height: 60),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(30.0),

                        ),
                        child:  Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: loginInputBackground,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50, // Adjust the width of the icon container as needed
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: Colors.white,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.person,
                                    color: accentColorDarkGreen1, // Icon color
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: 'Username',
                                      hintStyle: const TextStyle(color: Colors.white),
                                      alignLabelWithHint: true,
                                      filled: true,
                                      fillColor: loginInputBackground,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(30.0),

                        ),
                        child:  Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: loginInputBackground,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50, // Adjust the width of the icon container as needed
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: Colors.white,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.lock,
                                    color: accentColorDarkGreen1, // Icon color
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    obscureText: true,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: const TextStyle(color: Colors.white),
                                      alignLabelWithHint: true,
                                      filled: true,
                                      fillColor: loginInputBackground,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(25.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const LoginRegisterButton(buttonText: 'Log In'),
                      const SizedBox(height: 30),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        
                        child: SignUpLink(),
                      ),
                      const SizedBox(height: 180),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.52,
      height: 40,
      decoration: const BoxDecoration(
        color: Color(0xFF3F3F3F),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    );
  }
}
class RoundedContainer2 extends StatelessWidget {
  const RoundedContainer2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.52,
      height: 40,
      decoration: const BoxDecoration(
        color: Color(0xFF3F3F3F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
    );
  }
}
class InputField extends StatelessWidget {
  final String hintText;
  final bool obscureText;

  const InputField({super.key,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: const Color(0xFF545454),
        ),
        child: TextField(
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.white),
            alignLabelWithHint: true,
            filled: true,
            fillColor: const Color(0xFF545454),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.5),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF296829), width: 1.5),
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpLink extends StatelessWidget {
  const SignUpLink({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterPage()),
        );
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account? ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          Text(
            "Sign Up Now",
            style: TextStyle(
              color: Color(0xFF296829),
              fontWeight: FontWeight.w900,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
