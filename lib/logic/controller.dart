import 'package:flavor_ai_testing/logic/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flavor_ai_testing/logic/service.dart';
import 'models/filter_state.dart';
import 'models/recipe.dart';

class Controller with ChangeNotifier {
  UiState uiState = UiState();
  int currentIndex = 0;

  Future<void> searchRecipes() async {
    Map<String, String> parameter =
    uiState.filters.fold({}, (Map<String, String> map, FilterState filter) {
      if (filter.value != '...') {
        map[filter.filter] = filter.value;
      }
      return map;
    });
    parameter['query'] = uiState.query;
    List<Recipe> recipes = await Service.instance.fetchRecipes(parameter);
    uiState.recipes = recipes;
    notifyListeners();
  }

  void onQueryChange(String queryChange) {
    uiState.query = queryChange;
    searchRecipes();
  }

  void onFilterTap(filter) {
    FilterState filterState = uiState.getFilter(filter);
    filterState.displayed = !filterState.displayed;
    filterState.value = '...';
    searchRecipes();
  }

  void onDropdownChange(filter, value) {
    FilterState filterState = uiState.getFilter(filter);
    filterState.value = value.toString();
    filterState.displayed = true;
    searchRecipes();
  }

  void onRecipeTap(String recipeId) {
    uiState.recipeId = recipeId;
    navigateTo(4);
  }

  void navigateTo(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
