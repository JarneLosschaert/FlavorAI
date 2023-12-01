import 'package:flavor_ai_testing/logic/models/ingredient.dart';
import 'package:flavor_ai_testing/logic/models/instruction.dart';

class RecipeDetail {
  final int id;
  final String title;
  final String image;
  final int servings;
  final int healthScore;
  final int readyInMinutes;
  List<Ingredient> extendedIngredients = [];
  List<Instruction> analyzedInstructions = [];

  RecipeDetail({
    required this.id,
    required this.title,
    required this.image,
    this.servings = 0,
    this.healthScore = 0,
    this.readyInMinutes = 0,
    this.extendedIngredients = const [],
    this.analyzedInstructions = const [],
  });

  factory RecipeDetail.fromMap(Map<String, dynamic> map) {
    return RecipeDetail(
        id: map['id'],
        title: map['title'],
        image: map['image'],
        servings: map['servings'],
        healthScore: map['healthScore'],
        readyInMinutes: map['readyInMinutes'],
        extendedIngredients: List<Ingredient>.from(
            map['extendedIngredients'].map((x) => Ingredient.fromMap(x))),
        analyzedInstructions: List<Instruction>.from(
            map['analyzedInstructions'].map((x) => Instruction.fromMap(x))));
  }
}
