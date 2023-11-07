import 'package:flutter/cupertino.dart';
import '../../logic/models/recipe_detail.dart';
import '../../logic/services/recipes_service.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({
    super.key,
    required this.recipeId
  });

  final String recipeId;

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  void initState() {
    super.initState();
    _searchRecipe();
  }

  void _searchRecipe() async {
    RecipeDetail recipe = await ApiService.instance.fetchRecipeDetail(widget.recipeId);
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Recipe"),
    );
  }
}