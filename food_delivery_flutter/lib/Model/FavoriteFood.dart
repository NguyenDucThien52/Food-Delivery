
class FavoriteFood{
  final int favoriteFood_id;
  final int product_id;
  final String? email;

  FavoriteFood({required this.favoriteFood_id, required this.product_id, required this.email});

  factory FavoriteFood.fromJson(Map<String, dynamic> json) {
    return FavoriteFood(
        favoriteFood_id: json['favoriteFood_id'],
        product_id: json['product_id'],
        email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'favoriteFood_id': favoriteFood_id,
      'product_id': product_id,
      'email': email,
    };
  }

  factory FavoriteFood.toJson(Map<String, dynamic> json) {
    return FavoriteFood(
        favoriteFood_id: json['favoriteFood_id'],
        product_id: json['product_id'],
        email: json['email'],
    );
  }
}