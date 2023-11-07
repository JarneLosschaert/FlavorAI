import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import '../../logic/models/recipe_detail.dart';
import '../../logic/services/recipes_service.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({
    super.key,
    required this.onGoBack,
    required this.recipeId
  });

  final Function() onGoBack;
  final String recipeId;

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    _searchRecipe();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    widget.onGoBack.call();
    return true;
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
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