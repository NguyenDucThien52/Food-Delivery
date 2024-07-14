import 'package:flutter/foundation.dart';

class Order {
  final int order_id;
  final double totalAmount;
  final double quantity;
  final DateTime orderDate;
  final String deliveryAddress;
  final String paymentMethod;
  final String? email;
  final int receiver_id;
  final String order_Status;

  const Order(
      {required this.order_id,
      required this.totalAmount,
      required this.quantity,
      required this.orderDate,
      required this.deliveryAddress,
      required this.paymentMethod,
      required this.email,
      required this.receiver_id,
      required this.order_Status});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      order_id: json['order_id'],
      totalAmount: json['totalAmount'],
      quantity: json['quantity'],
      orderDate: DateTime.parse(json['orderDate']),
      deliveryAddress: json['deliveryAddress'],
      paymentMethod: json['paymentMethod'],
      email: json['email'],
      receiver_id: json['receiver_id'],
        order_Status: json['order_Status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': order_id,
      'totalAmount': totalAmount,
      'quantity': quantity,
      'orderDate': orderDate.toIso8601String(),
      'deliveryAddress': deliveryAddress,
      'paymentMethod': paymentMethod,
      'email': email,
      'receiver_id': receiver_id,
      'order_Status': order_Status,
    };
  }

  factory Order.toJson(Map<String, dynamic> json) {
    return Order(
      order_id: json['order_id'],
      totalAmount: json['totalAmount'],
      quantity: json['quantity'],
      orderDate: json['orderDate'],
      deliveryAddress: json['deliveryAddress'],
      paymentMethod: json['paymentMethod'],
      email: json['email'],
      receiver_id: json['receiver_id'],
        order_Status: json['order_Status'],
    );
  }
}
