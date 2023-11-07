import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flavor_ai_testing/constants/colors.dart';
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
    required this.onGoBack,
    required this.onQueryChange,
    required this.onFilterTap,
    required this.onDropdownChange,
    required this.onRecipeTapped,
  });

  final List<Recipe> recipes;
  final List<FilterState> filters;
  final Function() onGoBack;
  final Function(String query) onQueryChange;
  final Function(String filter) onFilterTap;
  final Function(String filter, String value) onDropdownChange;
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
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            BasicTitle(text: "Recipes", onGoBack: () => widget.onGoBack.call()),
            const Subtitle(text: "Search recipes"),
            SearchBarRecipes(
              onSubmitted: widget.onQueryChange,
            ),
            FilterBar(filters: widget.filters, onFilterTap: widget.onFilterTap),
            Container(height: 20),
            for (FilterState filter in widget.filters)
              if (filter.displayed == true)
                GeneralDropdown(
                  items: filter.items,
                  onChange: (value) {
                    widget.onDropdownChange(filter.filter, value.toString());
                  },
                  selectedValue: filter.value,
                  label: filter.filter[0].toUpperCase() +
                      filter.filter.substring(1).toLowerCase(),
                ),
            Recipes(recipes: widget.recipes, onRecipeTapped: widget.onRecipeTapped),
            Container(height: 20),
          ],
        ),
      ),
    );
  }
}

class FilterBar extends StatelessWidget {
  const FilterBar({
    Key? key,
    required this.filters,
    required this.onFilterTap,
  }) : super(key: key);

  final List<FilterState> filters;
  final ValueChanged<String> onFilterTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 20),
        const Subtitle(text: 'Filter'),
        Filters(
          filters: filters,
          onFilterChanged: (filter) {
            onFilterTap(filter);
          },
        )
      ],
    );
  }
}

class Filters extends StatelessWidget {
  const Filters({
    Key? key,
    required this.filters,
    required this.onFilterChanged,
  }) : super(key: key);

  final List<FilterState> filters;
  final ValueChanged<String> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (FilterState filterState in filters)
            Row(
              children: [
                Filter(
                  filter: filterState.filter,
                  isTapped: filterState.displayed,
                  onFilterChanged: (filter) {
                    onFilterChanged(filter);
                  },
                ),
                Container(width: 10),
              ],
            ),
        ],
      ),
    );
  }
}

class Filter extends StatelessWidget {
  const Filter({
    Key? key,
    required this.filter,
    required this.isTapped,
    required this.onFilterChanged,
  }) : super(key: key);

  final String filter;
  final bool isTapped;
  final ValueChanged<String> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onFilterChanged(filter);
      },
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isTapped ? primaryColor : primaryBackgroundColor,
        ),
        child: Center(
          child: Text(
            filter,
            style: TextStyle(
              fontSize: 16,
              color: isTapped ? tertiaryTextColor : primaryTextColor,
            ),
          ),
        ),
      ),
    );
  }
}

class Recipes extends StatelessWidget {
  const Recipes({
    Key? key,
    required this.recipes,
    required this.onRecipeTapped,
  }) : super(key: key);

  final List<Recipe> recipes;
  final Function(String recipeId) onRecipeTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryBackgroundColor,
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (Recipe recipe in recipes)
                RecipeCard(
                    recipeTitle: recipe.title,
                    imageURL: recipe.image,
                    id: recipe.id,
                    onRecipeTapped: onRecipeTapped),
            ],
          ),
          Container(height: 20),
        ],
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    Key? key,
    required this.recipeTitle,
    required this.imageURL,
    required this.id,
    required this.onRecipeTapped,
  }) : super(key: key);

  final String recipeTitle;
  final String imageURL;
  final int id;
  final Function(String recipeId) onRecipeTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onRecipeTapped(id.toString());
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
        padding: const EdgeInsets.all(5),
        height: 170,
        width: 146,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              child: ClipOval(
                child: Image.network(
                  imageURL,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                recipeTitle,
                style: TextStyle(fontSize: 18, color: tertiaryTextColor),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
