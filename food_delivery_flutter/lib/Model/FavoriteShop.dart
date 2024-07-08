class FavoriteShop{
  final int favoriteShop_id;
  final int shop_id;
  final String? email;

  FavoriteShop({required this.favoriteShop_id, required this.shop_id, required this.email});

  factory FavoriteShop.fromJson(Map<String, dynamic> json) {
    return FavoriteShop(
        favoriteShop_id: json['favoriteShop_id'],
        shop_id: json['shop_id'],
        email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'favoriteShop_id': favoriteShop_id,
      'shop_id': shop_id,
      'email': email,
    };
  }

  factory FavoriteShop.toJson(Map<String, dynamic> json) {
    return FavoriteShop(
      favoriteShop_id: json['favoriteShop_id'],
      shop_id: json['shop_id'],
      email: json['email'],
    );
  }

  factory FavoriteShop.empty(){
    return FavoriteShop(
        favoriteShop_id: 0,
        shop_id: 0,
        email: "",
    );
  }
}