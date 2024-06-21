import 'package:flutter/foundation.dart';

class Order{
  final int order_id;
  final double totalAmount;
  final DateTime orderDate;
  final String deliverlyAddress;
  final String email;

  const Order({required this.order_id, required this.totalAmount, required this.orderDate, required this.deliverlyAddress, required this. email});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        order_id: json['order_id'],
        totalAmount: json['totalAmount'],
        orderDate: json['orderDate'],
        deliverlyAddress: json['deliverlyAddress'],
        email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': order_id,
      'totalAmount': totalAmount,
      'orderDate': orderDate,
      'deliverlyAddress': deliverlyAddress,
      'email': email,
    };
  }

  factory Order.toJson(Map<String, dynamic> json) {
    return Order(
        order_id: json['order_id'],
        totalAmount: json['totalAmount'],
        orderDate: json['orderDate'],
        deliverlyAddress: json['deliverlyAddress'],
        email: json['email'],
    );
  }
}