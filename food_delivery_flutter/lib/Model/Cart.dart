import 'dart:ffi';

class Cart{
  final int cart_id;
  final String email;
  final List<int> cartItem_id;

  Cart({required this.cart_id, required this.email, required this.cartItem_id});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      cart_id: json['cart_id'],
      email: json['email'],
      cartItem_id: List<int>.from(json['cartItem_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cart_id': cart_id,
      'email': email,
      'cartItem_id': cartItem_id,
    };
  }

  factory Cart.toJson(Map<String, dynamic> json) {
    return Cart(
        cart_id: json['cart_id'],
        email: json['email'],
      cartItem_id: List<int>.from(json['cartItem_id']),
    );
  }
}