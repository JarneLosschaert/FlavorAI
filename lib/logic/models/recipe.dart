class Recipe {
  final int id;
  final String title;
  final String image;
  final String imageType;

  Recipe({
    required this.id, required this.title, required this.image, required this.imageType
  });

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      title: map['title'],
      image: map['image'],
      imageType: map['imageType'],
    );
  }

}