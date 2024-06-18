import 'dart:convert';

import 'package:food_delivery/Model/CartItem.dart';
import 'package:http/http.dart' as http;
class CartItemService{
  final String apiURL = "http://192.168.1.4:8080/api/cartItems";

  Future<CartItem> fetchCartItem(int product_id, int cart_id) async{
    final response = await http.get(Uri.parse(apiURL));
    if(response.statusCode == 200){
      return CartItem.fromJson(json.decode(response.body));
    }else{
      throw Exception("Failed to load cartItem");
    }
  }

  Future<List<CartItem>> fetchCartItemByCart(int cart_id) async{
    print(cart_id);
    print('$apiURL/getcartitemsbycart?cart_id=$cart_id');
    final response= await http.get(Uri.parse('$apiURL/getcartitemsbycart?cart_id=$cart_id'));
    if(response.statusCode == 200){
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      List<CartItem> cartItems = body.map((dynamic item) => CartItem.fromJson(item)).toList();
      return cartItems;
    }else{
      throw Exception("Failed to load cartItems");
    }
  }
  
  Future<void> saveCartItem(CartItem cartItem) async{
    print(cartItem.quantity);
    final response = await http.post(
        Uri.parse('$apiURL/insert'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(cartItem.toJson()));
    if(response.statusCode == 200){
      print("Create CartItem " + response.body + " successfully");
    }else{
      throw Exception("Failed to create cart item");
    }
  }
}