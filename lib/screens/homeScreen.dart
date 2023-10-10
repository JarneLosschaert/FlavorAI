import 'package:flutter/material.dart';

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
                backgroundColor: Colors.grey,
                onTap: () => {debugPrint("Recipes tapped")}),
          ),
          Flexible(
            flex: 1,
            child: HomeScreenCard(
                text: "Refrigerator",
                backgroundColor: Colors.grey,
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
                        backgroundColor: Color.fromARGB(255, 66, 66, 66),
                        onTap: () => widget.onCardTapped?.call(1),
                      )),
                ),
                Expanded(
                  child: AspectRatio(
                      aspectRatio: 1,
                      child: HomeScreenCard(
                        text: "Buy Premium",
                        backgroundColor: Color.fromARGB(255, 66, 66, 66),
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
                color: Colors.grey.withOpacity(0.5),
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