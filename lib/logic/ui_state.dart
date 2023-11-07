import 'package:flavor_ai_testing/constants/filter_items.dart';
import 'package:flavor_ai_testing/logic/models/filter_state.dart';
import 'models/recipe.dart';

class UiState {
  List<Recipe> recipes = [];
  String query = '';

  String recipeId = '';

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