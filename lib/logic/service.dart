import 'dart:io';

import 'package:flavor_ai_testing/logic/models/recipe.dart';
import 'package:flavor_ai_testing/logic/models/recipe_detail.dart';
import 'package:flavor_ai_testing/logic/repositories/repositories.dart';

class Service {
  Service._instantiate();
  static final Service instance = Service._instantiate();

  // recipe api

  Future<List<Recipe>> fetchRecipes(Map<String, String> parameters) async {
    return await Repositories.recipeApi.fetchRecipes(parameters);
  }

  Future<RecipeDetail> fetchRecipeDetail(String id) async {
    return await Repositories.recipeApi.fetchRecipeDetail(id);
  }
  

  // AI api

  Future<String> fetchProductsFromImage(File imageFile) async {
    return await Repositories.aiApi.fetchProductsFromImage(imageFile);
  }
}