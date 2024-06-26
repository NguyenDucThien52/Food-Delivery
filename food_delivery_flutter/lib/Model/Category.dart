class Category{
  final int category_id;
  final String name;
  final String imageURL;

  Category({required this.category_id, required this.name, required this.imageURL});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        category_id: json['category_id'],
        name: json['name'],
        imageURL: json['imageURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': category_id,
      'name': name,
      'imageURL': imageURL,
    };
  }

  factory Category.toJson(Map<String, dynamic> json) {
    return Category(
        category_id: json['category_id'],
        name: json['name'],
        imageURL: json['imageURL'],
    );
  }
}