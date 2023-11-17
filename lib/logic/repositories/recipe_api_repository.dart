import 'dart:convert';
import 'dart:io';

import 'package:flavor_ai_testing/logic/models/recipe.dart';
import 'package:flavor_ai_testing/logic/models/recipe_detail.dart';
import 'package:http/http.dart' as http;

class RecipeApiRepository {

  final String _baseURL = "api.spoonacular.com";
  static const String _apiKey = "36ff91910cc4441aa249e32ab7ac7813";

    Future<List<Recipe>> fetchRecipes(Map<String, String> parameters) async {
    parameters['apiKey'] = _apiKey;
    parameters['number'] = '20';
    Uri uri = Uri.https(
      _baseURL,
      '/recipes/complexSearch',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> rawRecipes = data['results'];
      List<Recipe> recipes =
          rawRecipes.map((dynamic item) => Recipe.fromMap(item)).toList();
      return recipes;
    } catch (err) {
      throw err.toString();
    }
  }

  Future<RecipeDetail> fetchRecipeDetail(String id) async {
    Map<String, String> parameters = {
      'includeNutrition': 'false',
      'apiKey': _apiKey,
    };
    Uri uri = Uri.https(
      _baseURL,
      '/recipes/$id/information',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    try {
      var response = await http.get(uri, headers: headers);
      Map<String, dynamic> data = json.decode(response.body);
      RecipeDetail recipe = RecipeDetail.fromMap(data);
      return recipe;
    } catch (err) {
      throw err.toString();
    }
  }
}