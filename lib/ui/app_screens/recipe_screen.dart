import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flavor_ai_testing/UI/components/general_components.dart';
import 'package:flavor_ai_testing/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flavor_ai_testing/logic/service.dart';

import '../../logic/models/recipe_detail.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key, required this.onGoBack, required this.recipe});

  final Function() onGoBack;
  final RecipeDetail recipe;

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    widget.onGoBack.call();
    return true;
  }

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  String _getRoundedAmount(double amount) {
    if (amount == amount.round()) {
      return amount.round().toString();
    } else {
      return amount.toStringAsFixed(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
      children: [
        BasicTitle(text: 'Recipe', onGoBack: widget.onGoBack, withGoBack: true),
        _buildRecipe(),
        Container(height: 10),
      ],
    ));
  }

  Widget _buildRecipe() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryBackgroundColor,
      ),
      child: Column(
        children: [
          _buildHeader(),
          _buildBody(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Image.network(
            widget.recipe.image,
            fit: BoxFit.cover,
          ),
        ),
        Container(height: 10),
        Text(widget.recipe.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
      ],
    );
  }

  Widget _buildBody() {
    return Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _buildInfo(),
            Container(height: 10),
            _buildIngredients(),
            Container(height: 20),
            _buildInstructions(),
          ],
        ));
  }

  Widget _buildInfo() {
    return Container(
        padding: const EdgeInsets.only(bottom: 10, top: 20),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFF787878)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildInfoDetail(
                'health score', widget.recipe.healthScore.toString()),
            _buildInfoDetail(
                'minutes', widget.recipe.readyInMinutes.toString()),
            _buildInfoDetail('servings', widget.recipe.servings.toString()),
          ],
        ));
  }

  Widget _buildInfoDetail(String title, String value) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor)),
        Text(title),
      ],
    );
  }

  Widget _buildIngredients() {
    return Container(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: secondaryColor,
        ),
        child: SizedBox(
          child: Column(
            children: [
              for (var ingredient in widget.recipe.extendedIngredients)
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: 25,
                            width: 100,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                                '${_getRoundedAmount(ingredient.amount)} ${ingredient.unit}',
                                style: TextStyle(color: tertiaryTextColor))),
                        Container(width: 10),
                        Expanded(
                            child: Text(ingredient.name,
                                style: const TextStyle(fontSize: 16)))
                      ],
                    ),
                    Container(height: 10),
                  ],
                )
            ],
          ),
        ));
  }

  Widget _buildInstructions() {
    return Column(
      children: [
        for (var step in widget.recipe.analyzedInstructions[0].steps)
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 20,
                    height: 20,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(step.number.toString(),
                        style: TextStyle(color: tertiaryTextColor))),
                Container(width: 10),
                Expanded(
                  child: Text(step.step, style: const TextStyle(fontSize: 16)),
                ),
              ],
            ),
          )
      ],
    );
  }
}
