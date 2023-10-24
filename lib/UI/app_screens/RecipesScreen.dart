import 'package:flavor_ai_testing/UI/helpers/Searchbar.dart';
import 'package:flavor_ai_testing/UI/helpers/General.dart';
import 'package:flavor_ai_testing/constants/colors.dart';
import 'package:flutter/material.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({super.key});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:Container(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          const BasicTitle(text: "Recipes"),
          const Subtitle(text: "Search recipes"),
          SearchBarRecipes(
            onSubmitted: (query) {
              // Handle the search query (e.g., filter results)
            },
          ),
          Container(height: 20),
          const Recipes(),
          Container(height: 20),
        ],
      ),
        )
    );
  }
}

class Recipes extends StatelessWidget {
  const Recipes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryBackgroundColor,
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Recipes",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Container(height: 20),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              Recipe(recipeTitle: "Salmon salad", time: "30m"),
              Recipe(recipeTitle: "Salmon salad", time: "30m"),
              Recipe(recipeTitle: "Salmon salad", time: "30m"),
              Recipe(recipeTitle: "Salmon salad", time: "30m"),
              Recipe(recipeTitle: "Salmon salad", time: "30m"),
              Recipe(recipeTitle: "Salmon salad", time: "30m"),
              Recipe(recipeTitle: "Salmon salad", time: "30m"),
              Recipe(recipeTitle: "Salmon salad", time: "30m"),
              Recipe(recipeTitle: "Salmon salad", time: "30m"),
            ],
          ),
          Container(height: 20),
        ],
      ),
    );
  }
}

class Recipe extends StatelessWidget {
  const Recipe({
    Key? key,
    required this.recipeTitle,
    required this.time,
  }) : super(key: key);

  final String recipeTitle;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage('assets/images/background-recipe.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(5),
      height: 150,
      width: 146,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            child: const Image(
              image: AssetImage('assets/logo/logo.png'),
              height: 80,
              width: 80,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recipeTitle,
                style: TextStyle(
                    fontSize: 18,
                    color: tertiaryTextColor
                ),
              ),
              Text(
                time,
                style: TextStyle(
                    fontSize: 15,
                    color: tertiaryTextColor
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
