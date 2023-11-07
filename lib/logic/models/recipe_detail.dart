class RecipeDetail {
  final int id;
  final String title;
  final String image;
  final String imageType;
  final bool vegetarian;

  RecipeDetail({
    required this.id, required this.title, required this.image, required this.imageType, required this.vegetarian
  });

  factory RecipeDetail.fromMap(Map<String, dynamic> map) {
    return RecipeDetail(
      id: map['id'],
      title: map['title'],
      image: map['image'],
      imageType: map['imageType'],
      vegetarian: map['vegetarian'],
    );
  }

}