import 'package:flavor_ai_testing/constants/colors.dart';
import 'package:flutter/material.dart';

class BasicTitle extends StatelessWidget {
  const BasicTitle({
    Key? key,
    required this.text,
    this.withGoBack = true,
    this.onGoBack,
  }) : super(key: key);

  final String text;
  final bool withGoBack;
  final void Function()? onGoBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (withGoBack)
            Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    onGoBack?.call();
                  },
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
                ))
          else
            Expanded(flex: 1, child: Container()),
          Expanded(
              flex: 3,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Expanded(flex: 1,child: Container(),),
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

class GeneralDropdown extends StatelessWidget {
  const GeneralDropdown({
    Key? key,
    required this.items,
    required this.onChange,
    required this.selectedValue,
    this.label = '',
    this.withLabel = true,
  }) : super(key: key);

  final List<String> items;
  final void Function(String?) onChange;
  final String selectedValue;
  final String label;
  final bool withLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (withLabel) Subtitle(text: label),
        Container(
          height: 30,
          padding: const EdgeInsets.only(left: 10, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: primaryBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue, // Set the value to selectedValue
              onChanged: onChange,
              items: [
                for (String item in items)
                  DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                  ),
              ],
              hint: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Container(height: 10),
      ],
    );
  }
}

