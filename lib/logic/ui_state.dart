import 'package:flavor_ai_testing/constants/filter_items.dart';
import 'package:flavor_ai_testing/logic/models/filter_state.dart';
import 'package:flavor_ai_testing/logic/models/recipe_detail.dart';
import 'models/recipe.dart';

class UiState {
  List<Recipe> recipes = [];
  String query = '';
  String sort = sortItems[0];
  String sortDirection = 'desc';

  RecipeDetail recipeDetail = RecipeDetail(id: -1, title: '', image: '');

  FilterState ingredientsFilter = FilterState('includeIngredients', ["tomato", "cheese"]);
  final List<FilterState> filters = [
    FilterState('cuisine', cuisines),
    FilterState('diet', diets),
    FilterState('intolerance', intolerances),
    FilterState('type', types),
  ];

  FilterState getFilter(filter) {
    return filters.firstWhere((element) => element.filter == filter,
        orElse: () => FilterState(filter, []));
  }
}