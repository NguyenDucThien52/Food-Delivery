import 'dart:ffi';

class Cart{
  final int? cart_id;
  final String? email;
  final List<int> product_id;

  Cart({this.cart_id, this.email, required this.product_id});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      cart_id: json['cart_id'],
      email: json['email'],
      product_id: List<int>.from(json['product_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cart_id': cart_id,
      'email': email,
      'product_id': product_id,
    };
  }

  factory Cart.toJson(Map<String, dynamic> json) {
    return Cart(
        cart_id: json['cart_id'],
        email: json['email'],
        product_id: List<int>.from(json['product_id']),
    );
  }
}