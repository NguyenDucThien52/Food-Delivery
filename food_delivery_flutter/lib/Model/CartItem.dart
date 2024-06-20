class CartItem{
  final int cartItem_id;
  int quantity;
  final int product_id;
  final int cart_id;


  CartItem({required this.cart_id, required this.quantity, required this.product_id, required this.cartItem_id});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
        cartItem_id: json['cartItem_id'],
        quantity: json['quantity'],
        product_id: json['product_id'],
        cart_id: json['cart_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cartItem_id': cartItem_id,
      'quantity': quantity,
      'product_id': product_id,
      'cart_id': cart_id,
    };
  }

  factory CartItem.toJson(Map<String, dynamic> json) {
    return CartItem(
        cartItem_id: json['cartItem_id'],
        quantity: json['quantity'],
        product_id: json['product_id'],
        cart_id: json['cart_id'],
    );
  }
}