import 'dart:convert';

import 'package:food_delivery/Model/OrderItem.dart';
import 'package:http/http.dart' as http;

class OrderItemService {
  final String apiUrl = "http://192.168.1.4:8080/api/orderItems";

  Future<List<OrderItem>> fetchOrderItems(int order_id) async {
    final response = await http.get(Uri.parse('$apiUrl?order_id=$order_id'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      List<OrderItem> orderItems = body.map((dynamic item) => OrderItem.fromJson(item)).toList();
      return orderItems;
    } else {
      throw Exception("Failed to load orderitems");
    }
  }

  Future<void> saveOrderItem(OrderItem orderItem) async {
    final response = await http.post(
      Uri.parse('$apiUrl/insert'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(orderItem.toJson()),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("Create orderItem successfully");
    } else {
      throw Exception("Failed to create orderItem");
    }
  }
}
