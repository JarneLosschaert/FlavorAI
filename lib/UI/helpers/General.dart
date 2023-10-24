import 'package:flavor_ai_testing/constants/colors.dart';
import 'package:flutter/material.dart';

class BasicTitle extends StatelessWidget {
  const BasicTitle({
    Key? key,
    required this.text,
    this.withGoBack = true,
  }) : super(key: key);

  final String text;
  final bool withGoBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (withGoBack)
            Expanded(
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: secondaryTextColor,
                    size: 15,
                  ),
                  Text(
                    "Go back",
                    style: TextStyle(
                      fontSize: 13,
                      color: secondaryTextColor,
                    ),
                  ),
                ],
              ),
            )
          else
            Expanded(child: Container()),
          Expanded(child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          )),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}

class Subtitle extends StatelessWidget {
  const Subtitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: secondaryTextColor,
        ),
      ),
    );
  }
}