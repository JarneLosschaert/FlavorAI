import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flavor_ai_testing/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.amountOfIngredients,
    this.onCardTapped,
  });

  final int amountOfIngredients;
  final Function(int)? onCardTapped;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Exit App"),
          content: const Text("Do you want to exit the app?"),
          actions: <Widget>[
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            ),
          ],
        );
      },
    );
    return true;
  }

  @override
  void initState() {
    BackButtonInterceptor.add(myInterceptor);
    super.initState();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      constraints: const BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildHomeCard(
            'Recipes',
            'Search your recipes',
            'assets/images/recipes.jpg',
            () => widget.onCardTapped?.call(3),
          ),
          _buildHomeCard(
            'Ingredients',
            'You saved ${widget.amountOfIngredients} ingredients',
            'assets/images/ingredients.webp',
            () => widget.onCardTapped?.call(5),
          ),
          _buildHomeCard(
            'Scan',
            'Scan your ingredients',
            'assets/images/scan.png',
            () => widget.onCardTapped?.call(1),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeCard(
      String text, String subText, String image, VoidCallback onTap) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: 175,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: secondaryBackgroundColor.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 24,
                    color: tertiaryTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  subText,
                  style: TextStyle(
                    fontSize: 16,
                    color: tertiaryTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ));
  }
}
