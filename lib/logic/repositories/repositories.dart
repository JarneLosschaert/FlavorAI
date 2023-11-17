import 'package:flavor_ai_testing/logic/repositories/ai_api_repository.dart';
import 'package:flavor_ai_testing/logic/repositories/recipe_api_repository.dart';

class Repositories {
  static final RecipeApiRepository _recipeApi = RecipeApiRepository();
  static final AIApiRepository _aiApi = AIApiRepository();

  static RecipeApiRepository get recipeApi => _recipeApi;
  static AIApiRepository get aiApi => _aiApi;
}
