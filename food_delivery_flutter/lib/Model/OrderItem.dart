class OrderItem{
  final int orderItem_id;
  final int quantity;
  final int product_id;
  final int order_id;

  OrderItem({required this.orderItem_id, required this.quantity, required this.product_id, required this.order_id});

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
        orderItem_id: json['orderItem_id'],
        quantity: json['quantity'],
        product_id: json['product_id'],
        order_id: json['order_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderItem_id': orderItem_id,
      'quantity': quantity,
      'product_id': product_id,
      'order_id': order_id,
    };
  }

  factory OrderItem.toJson(Map<String, dynamic> json) {
    return OrderItem(
        orderItem_id: json['orderItem_id'],
        quantity: json['quantity'],
        product_id: json['product_id'],
        order_id: json['order_id'],
    );
  }
}