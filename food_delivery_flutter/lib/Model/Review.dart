class Review{
  final int review_id;
  final int rating;
  final String? email;
  final int product_id;

  Review({required this.review_id, required this.rating, required this.email, required this.product_id});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
        review_id: json['review_id'],
        rating: json['rating'],
        email: json['email'],
        product_id: json['product_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'review_id': review_id,
      'rating': rating,
      'email': email,
      'product_id': product_id,
    };
  }

  factory Review.toJson(Map<String, dynamic> json) {
    return Review(
        review_id: json['review_id'],
        rating: json['rating'],
        email: json['email'],
        product_id: json['product_id'],
    );
  }
}