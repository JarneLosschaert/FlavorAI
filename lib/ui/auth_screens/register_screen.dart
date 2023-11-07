import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'login_screen.dart';
import '../components/login_register_button.dart';



class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color myBackgroundColorLogin = Color(0xFF2F2F2F);
    const Color myBackgroundColorAccentLogin = Color(0xFF3F3F3F);
    const Color loginInputBackground = Color(0xFF545454);
    const Color accentColorDarkGreen1 = Color(0xFF296829);

    return Scaffold(
      backgroundColor: myBackgroundColorLogin,
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
          child: Stack(
            children: [
              // Rounded Rectangle
              Positioned(
                left: 0,
                top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.6 - 37.5,
                // 60% height - half of the rectangle's height
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.52,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: myBackgroundColorAccentLogin,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      // Adjust the radius as needed
                      bottomRight: Radius.circular(
                          20), // Adjust the radius as needed
                    ),
                  ),
                ),
              ),

              Positioned(
                right: 0,
                top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.675 - 37.5,
                // 60% height - half of the rectangle's height
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.52,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: myBackgroundColorAccentLogin,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      // Adjust the radius as needed
                      bottomLeft: Radius.circular(
                          20), // Adjust the radius as needed
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 0,
                top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.75 - 37.5,
                // 60% height - half of the rectangle's height
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.52,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: myBackgroundColorAccentLogin,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      // Adjust the radius as needed
                      bottomRight: Radius.circular(
                          20), // Adjust the radius as needed
                    ),
                  ),
                ),
              ),

              Positioned(
                right: 0,
                top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.825 - 37.5,
                // 60% height - half of the rectangle's height
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.52,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: myBackgroundColorAccentLogin,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      // Adjust the radius as needed
                      bottomLeft: Radius.circular(
                          20), // Adjust the radius as needed
                    ),
                  ),
                ),
              ),

              // Rest of your content
              SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      SvgPicture.asset(
                        'assets/images/flavorAI.svg',
                        // Replace with the path to your SVG asset
                        width: 125.0, // Adjust the width as needed
                        height: 125.0, // Adjust the height as needed
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
                                    Icons.mail,
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
                                      hintText: 'Email',
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
                                    obscureText: true,
                                    textAlign: TextAlign.center,
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
                                    obscureText: true,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: 'Repeat Password',
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

                      const LoginRegisterButton(buttonText: 'Sign Up'),

                      const SizedBox(height: 30),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: LoginLink()
                      )
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

class LoginLink extends StatelessWidget {
  const LoginLink({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account? ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          Text(
            "Log In Here",
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
