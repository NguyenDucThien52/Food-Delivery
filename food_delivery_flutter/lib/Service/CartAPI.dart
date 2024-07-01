import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:food_delivery/Model/Cart.dart';

class CartService{
  final String apiUrl = "http://192.168.1.4:8080/api/carts";
  final String? email = FirebaseAuth.instance.currentUser!.email;


  Future<Cart> fetchCart() async {
    final response = await http.get(Uri.parse('$apiUrl?email=$email'));
    if (response.statusCode == 200) {
      return Cart.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load cart');
    }
  }

  Future<void> saveCart(Cart cart) async {
    final response = await http.post(
      Uri.parse('$apiUrl/insert'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(cart.toJson()),
    );

    if (response.statusCode == 200) {
      print("Create order Successfully");
    } else {
      throw Exception('Failed to create cart');
    }
  }
}