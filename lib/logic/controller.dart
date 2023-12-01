import 'package:flavor_ai_testing/logic/services/recipes_service.dart';
import 'package:flavor_ai_testing/logic/ui_state.dart';
import 'package:flutter/material.dart';

import 'models/filter_state.dart';
import 'models/recipe.dart';

class Controller with ChangeNotifier {
  UiState uiState = UiState();
  int currentIndex = 0;

  Future<void> getRecipes() async {
    Map<String, String> parameter =
        uiState.filters.fold({}, (Map<String, String> map, FilterState filter) {
      if (filter.value != '...') {
        map[filter.filter] = filter.value;
      }
      return map;
    });
    if (uiState.ingredientsFilter.value != '...') {
      parameter[uiState.ingredientsFilter.filter] =
          uiState.ingredientsFilter.value;
    }
    parameter['query'] = uiState.query;
    if (uiState.ingredientsFilter.displayed &&
        uiState.ingredientsFilter.items.isNotEmpty) {
      parameter['includeIngredients'] =
          uiState.ingredientsFilter.items.join(',');
    }
    parameter['sort'] = uiState.sort;
    parameter['sortDirection'] = uiState.sortDirection;
    List<Recipe> recipes = await ApiService.instance.fetchRecipes(parameter);
    uiState.recipes = recipes;
    notifyListeners();
  }

  void onQueryChange(String queryChange) {
    uiState.query = queryChange;
    getRecipes();
  }

  void onFilterTap(filter) {
    FilterState filterState = uiState.getFilter(filter);
    filterState.displayed = !filterState.displayed;
    filterState.value = '...';
    getRecipes();
  }

  void onIngredientsTap() {
    uiState.ingredientsFilter.displayed = !uiState.ingredientsFilter.displayed;
    getRecipes();
  }

  void onDropdownChange(filter, value) {
    FilterState filterState = uiState.getFilter(filter);
    filterState.value = value.toString();
    filterState.displayed = true;
    getRecipes();
  }

  void onSortChange(String sort) {
    uiState.sort = sort;
    getRecipes();
  }

  void onSortDirectionChange() {
    uiState.sortDirection = uiState.sortDirection == 'asc' ? 'desc' : 'asc';
    getRecipes();
  }

  Future<void> onRecipeTap(String recipeId) async {
    uiState.recipeDetail =
        await ApiService.instance.fetchRecipeDetail(recipeId);
    navigateTo(4);
  }

  void navigateTo(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
