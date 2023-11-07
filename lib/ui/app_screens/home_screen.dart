import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flavor_ai_testing/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.onCardTapped,
  });

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
      constraints: const BoxConstraints.expand(),
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: HomeScreenCard(
                text: "Recipes",
                subText: "You have saved 0 recipes",
                backgroundColor: secondaryBackgroundColor,
                onTap: () => {widget.onCardTapped?.call(3)}),
          ),
          Flexible(
            flex: 1,
            child: HomeScreenCard(
                text: "Refrigerator",
                backgroundColor: secondaryBackgroundColor,
                onTap: () => {debugPrint("Refrigerator tapped")}),
          ),
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: AspectRatio(
                      aspectRatio: 1,
                      child: HomeScreenCard(
                        text: "3 free scans",
                        backgroundColor: tertiaryColor,
                        onTap: () => widget.onCardTapped?.call(1),
                      )),
                ),
                Expanded(
                  child: AspectRatio(
                      aspectRatio: 1,
                      child: HomeScreenCard(
                        text: "Buy Premium",
                        backgroundColor: tertiaryColor,
                        onTap: () => {debugPrint("Buy Premium tapped")},
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class HomeScreenCard extends StatelessWidget {
  final String text;
  final String? subText;
  final Color backgroundColor;
  final VoidCallback? onTap;

  const HomeScreenCard({
    super.key,
    required this.text,
    this.subText,
    required this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: secondaryBackgroundColor.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
            color: backgroundColor,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (subText != null)
                  Text(
                    subText!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          ),
        ));
  }
}
