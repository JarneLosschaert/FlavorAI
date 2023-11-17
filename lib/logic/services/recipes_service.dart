import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

import '../models/recipe.dart';
import '../models/recipe_detail.dart';

class ApiService {
  ApiService._instantiate();

  static final ApiService instance = ApiService._instantiate();
  final String _baseURL = "api.spoonacular.com";
  static const String _apiKey = "36ff91910cc4441aa249e32ab7ac7813";
  static const String _flaskApiIp = "192.168.1.110:9090";

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

  Future<String> fetchProductsFromImage(File imageFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://${_flaskApiIp}/detect_products'),
    );

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
        filename: path.basename(imageFile.path),
      ),
    );

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw 'Failed to upload image. Status code: ${response.statusCode}';
      }
    } catch (err) {
      throw err.toString();
    }
  }
}
