import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../Model/Order.dart';

class OrderService {
  final String apiUrl = "http://192.168.1.4:8080/api/orders";
  final String? email = FirebaseAuth.instance.currentUser!.email;

  Future<List<Order>> fetchOrder() async {
    final response = await http.get(Uri.parse('$apiUrl?email=$email'));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      List<Order> orders = body.map((dynamic item) => Order.fromJson(item)).toList();
      return orders;
    } else {
      throw Exception("Failed to load order");
    }
  }

  Future<List<Order>> getAllOrders() async {
    final response = await http.get(Uri.parse('$apiUrl/getall'));
    if(response.statusCode == 200){
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      List<Order> orders = body.map((dynamic item) => Order.fromJson(item)).toList();
      return orders;
    }else{
      throw Exception("Failed to load order");
    }
  }

  Future<void> insertOrder(Order order) async {
    final response = await http.post(Uri.parse('$apiUrl/insert'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(order.toJson()));
    if (response.statusCode == 200) {
      print("Create order successfully!");
    } else {
      throw Exception("Failed to create order");
    }
  }
}
