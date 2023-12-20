import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flavor_ai_testing/constants/colors.dart';
import 'package:flavor_ai_testing/constants/filter_items.dart';
import 'package:flavor_ai_testing/logic/models/filter_state.dart';
import 'package:flavor_ai_testing/logic/models/recipe.dart';
import 'package:flutter/material.dart';

import '../components//general_components.dart';
import '../components/searchbar.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({
    super.key,
    required this.recipes,
    required this.filters,
    required this.ingredientsFilter,
    required this.sort,
    required this.sortDirection,
    required this.onGoBack,
    required this.onQueryChange,
    required this.onFilterTap,
    required this.onIngredientsTap,
    required this.onDropdownChange,
    required this.onSortChange,
    required this.onSortDirectionChange,
    required this.onRecipeTapped,
  });

  final List<Recipe> recipes;
  final List<FilterState> filters;
  final FilterState ingredientsFilter;
  final String sort;
  final String sortDirection;
  final Function() onGoBack;
  final Function(String query) onQueryChange;
  final Function(String filter) onFilterTap;
  final Function() onIngredientsTap;
  final Function(String filter, String value) onDropdownChange;
  final Function(String sort) onSortChange;
  final Function() onSortDirectionChange;
  final Function(String recipeId) onRecipeTapped;

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    widget.onGoBack.call();
    return true;
  }

  @override
  void initState() {
    BackButtonInterceptor.add(myInterceptor);
    super.initState();
    widget.onQueryChange('');
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          BasicTitle(text: "Recipes", onGoBack: () => widget.onGoBack.call()),
          _buildSearchBar(),
          Container(height: 20),
          _buildFilterBar(),
          Container(height: 20),
          _buildFilters(),
          _buildRecipes(),
          Container(height: 20),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Column(children: [
      const Subtitle(text: "Search recipes"),
      SearchBarRecipes(
        onSubmitted: widget.onQueryChange,
      ),
    ]);
  }

  Widget _buildFilterBar() {
    return Column(
      children: [
        const Subtitle(text: 'Filter'),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildIconFilter(),
              Container(width: 10),
              for (FilterState filterState in widget.filters)
                Row(
                  children: [
                    _buildFilter(filterState),
                    Container(width: 10),
                  ],
                ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildIconFilter() {
    return GestureDetector(
      onTap: () {
        widget.onIngredientsTap.call();
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.ingredientsFilter.displayed ? primaryColor : primaryBackgroundColor,
        ),
        child: Center(
          child: Image.asset('assets/images/fridge.png')
        ),
      ),
    );
  }

  Widget _buildFilter(FilterState filter) {
    return GestureDetector(
      onTap: () {
        widget.onFilterTap(filter.filter);
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: filter.displayed ? primaryColor : primaryBackgroundColor,
        ),
        child: Center(
          child: Text(
            filter.filter,
            style: TextStyle(
              fontSize: 16,
              color: filter.displayed ? tertiaryTextColor : primaryTextColor,
            ),
          ),
        ),
      ),
    );
  }

  _buildFilters() {
    return Column(
      children: [
        for (FilterState filter in widget.filters)
          if (filter.displayed == true)
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Subtitle(
                  text: filter.filter[0].toUpperCase() +
                      filter.filter.substring(1).toLowerCase()),
              _buildDropdown(filter.items, filter.value, (value) {
                widget.onDropdownChange(filter.filter, value);
              }),
              Container(height: 20),
            ])
      ],
    );
  }

  Widget _buildDropdown(
      List<String> items, String value, Function(String) onChange) {
    return Container(
      height: 30,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          onChanged: (value) {
            onChange(value!);
          },
          items: [
            for (String item in items)
              DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
          ],
          hint: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecipes() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryBackgroundColor,
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSort(),
          Container(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (Recipe recipe in widget.recipes) _buildRecipe(recipe),
            ],
          ),
          Container(height: 20),
        ],
      ),
    );
  }

  Widget _buildRecipe(Recipe recipe) {
    return GestureDetector(
      onTap: () {
        widget.onRecipeTapped(recipe.id.toString());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
            image: AssetImage('assets/images/background-recipe.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
        height: 170,
        width: 146,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Image.network(
                  recipe.image,
                  height: 80,
                  width: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                recipe.title,
                style: TextStyle(fontSize: 17, color: tertiaryTextColor, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSort() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Sort by',
          style: TextStyle(
            fontSize: 14,
            color: primaryTextColor,
          ),
        ),
        Container(width: 10),
        _buildDropdown(
          sortItems,
          widget.sort,
          (value) {
            widget.onSortChange(value);
          },
        ),
        if (widget.sortDirection == 'asc')
          IconButton(
            onPressed: widget.onSortDirectionChange,
            icon: const Icon(Icons.arrow_upward),
            color: primaryColor,
          )
        else
          IconButton(
            onPressed: widget.onSortDirectionChange,
            icon: const Icon(Icons.arrow_downward),
            color: primaryColor,
          ),
      ],
    );
  }
}
