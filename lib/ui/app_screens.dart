import 'package:camera/camera.dart';
import 'package:flavor_ai_testing/UI/app_screens/home_screen.dart';
import 'package:flavor_ai_testing/UI/app_screens/recipes_screen.dart';
import 'package:flavor_ai_testing/UI/app_screens/scanner_screen.dart';
import 'package:flavor_ai_testing/UI/app_screens/settings_screen.dart';
import 'package:flavor_ai_testing/constants/colors.dart';
import 'package:flavor_ai_testing/logic/controller.dart';
import 'package:flavor_ai_testing/ui/app_screens/recipe_screen.dart';
import 'package:flavor_ai_testing/ui/app_screens/ingredients_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppScreens extends StatefulWidget {
  const AppScreens({super.key});

  @override
  State<AppScreens> createState() => _AppScreensState();
}

class _AppScreensState extends State<AppScreens> {
  CameraDescription? _camera;

  @override
  initState() {
    WidgetsFlutterBinding.ensureInitialized();
    initCamera();
    super.initState();
  }

  Future<void> initCamera() async {
    final camera = await availableCameras().then((value) => value.first);
    setState(() {
      _camera = camera;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context);
    final List<Widget> pages = [
      HomeScreen(
        amountOfIngredients: controller.uiState.ingredientsFilter.items.length,
        onCardTapped: controller.navigateTo,
      ),
      _camera != null
          ? ScannerScreen(
            camera: _camera!,
              onGoBack: () => controller.navigateTo(0), 
              onItemsPressed: () => controller.navigateTo(5),
              addIngredient: controller.addIngredient)
          : Container(),
      SettingsScreen(
        onGoBack: () => controller.navigateTo(0),
      ),
      RecipesScreen(
        onGoBack: () => controller.navigateTo(0),
        recipes: controller.uiState.recipes,
        filters: controller.uiState.filters,
        ingredientsFilter: controller.uiState.ingredientsFilter,
        sort: controller.uiState.sort,
        sortDirection: controller.uiState.sortDirection,
        onQueryChange: controller.onQueryChange,
        onFilterTap: controller.onFilterTap,
        onIngredientsTap: controller.onIngredientsTap,
        onDropdownChange: controller.onDropdownChange,
        onSortChange: controller.onSortChange,
        onSortDirectionChange: controller.onSortDirectionChange,
        onRecipeTapped: controller.onRecipeTap,
      ),
      RecipeScreen(
        onGoBack: () => controller.navigateTo(3),
        recipe: controller.uiState.recipeDetail,
      ),
      IngredientsScreen(
          ingredients: controller.uiState.ingredientsFilter.items,
          addIngredient: controller.addIngredient,
          removeIngredient: controller.removeIngredient,
          onGoBack: () => controller.navigateTo(0)),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: const EdgeInsets.only(top: 38),
          child: pages[controller.currentIndex],
        ),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
      bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomNavigationBarItem(
                  icon: Icons.home,
                  index: 0,
                  currentIndex: controller.currentIndex,
                  onTap: () => controller.navigateTo(0),
                ),
                CustomNavigationBarItem(
                  icon: Icons.camera_alt,
                  index: 1,
                  currentIndex: controller.currentIndex,
                  onTap: () => controller.navigateTo(1),
                ),
                CustomNavigationBarItem(
                  icon: Icons.settings,
                  index: 2,
                  currentIndex: controller.currentIndex,
                  onTap: () => controller.navigateTo(2),
                ),
              ],
            ),
          )),
    );
  }
}

class CustomNavigationBarItem extends StatelessWidget {
  final IconData icon;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;

  const CustomNavigationBarItem({
    super.key,
    required this.icon,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == currentIndex;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? primaryColor : secondaryColor,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
