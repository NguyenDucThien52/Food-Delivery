import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/Model/FavoriteShop.dart';
import 'package:http/http.dart' as http;

class FavoriteShopService {
  final String apiUrl = "http://192.168.1.4:8080/api/favorite_shops";
  final String? email = FirebaseAuth.instance.currentUser!.email;

  Future<FavoriteShop> getFavoriteShop(int shop_id) async{
    final response = await http.get(Uri.parse('$apiUrl?shop_id=$shop_id&email=$email'));
    if(response.statusCode == 200){
      return FavoriteShop.fromJson(json.decode(response.body));
    }else{
      throw Exception("Failed to load favorite shop");
    }
  }

  Future<void> saveFavoriteShop(FavoriteShop favoriteShop) async {
    final response = await http.post(
      Uri.parse('$apiUrl/insert'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(favoriteShop.toJson()),
    );
    if (response.statusCode == 200) {
      print("Create favorite shop successfully!");
    }
  }

  Future<void> deleteFavoriteShop(int id) async{
    final response = await http.get(Uri.parse('$apiUrl/delete?favoriteShop_id=$id'));
    if(response.statusCode == 200){
      print("delete favorite shop successfully!");
    }else{
      throw Exception("Failed to delete favorite shop");
    }
  }
}
