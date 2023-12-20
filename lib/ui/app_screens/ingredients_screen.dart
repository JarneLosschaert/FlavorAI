import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../components/general_components.dart';

class IngredientsScreen extends StatefulWidget {
  const IngredientsScreen({
    super.key,
    required this.ingredients,
    required this.addIngredient,
    required this.removeIngredient,
    required this.onGoBack,
  });

  final List<String> ingredients;
  final Function(String) addIngredient;
  final Function(String) removeIngredient;
  final Function() onGoBack;

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    widget.onGoBack.call();
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
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              BasicTitle(
                text: "Ingredients",
                onGoBack: () => widget.onGoBack.call(),
              ),
              _buildIngredients(),
            ],
          ),
        ),
        _buildAddButton(),
      ],
    );

  }

  Widget _buildIngredients() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryBackgroundColor,
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Subtitle(text: "Your ingredients:"),
          Container(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (String ingredient in widget.ingredients)
                _buildIngredient(ingredient),
            ],
          ),
          Container(height: 20),
        ],
      ),
    );
  }

  Widget _buildIngredient(String ingredient) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              ingredient,
              style: TextStyle(
                fontSize: 16,
                color: tertiaryTextColor,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              widget.removeIngredient.call(ingredient);
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: errorColor,
              ),
              child: Icon(
                Icons.remove,
                color: tertiaryTextColor,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildAddButton() {
    return Stack(
      children: [
        Positioned(
          bottom: 20,
          right: 20,
          child: GestureDetector(
            onTap: () {
              _showIngredientPopup(context);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor,
              ),
              child: Icon(
                Icons.add,
                color: tertiaryTextColor,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showIngredientPopup(BuildContext context) {
    TextEditingController ingredientController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add ingredient'),
          content: TextField(
            controller: ingredientController,
            decoration: const InputDecoration(labelText: 'Ingredient'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                widget.addIngredient.call(ingredientController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
