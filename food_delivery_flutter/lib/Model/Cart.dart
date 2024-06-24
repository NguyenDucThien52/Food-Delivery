import 'dart:ffi';

class Cart{
  final int cart_id;
  final String email;

  Cart({required this.cart_id, required this.email});

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      cart_id: json['cart_id'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cart_id': cart_id,
      'email': email,
    };
  }

  factory Cart.toJson(Map<String, dynamic> json) {
    return Cart(
        cart_id: json['cart_id'],
        email: json['email'],
    );
  }
}