import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../Model/FavoriteFood.dart';

class FavoriteFoodService{
  final String apiUrl = "http://192.168.1.4:8080/api/favorite_foods";
  final String? email = FirebaseAuth.instance.currentUser!.email;

  Future<List<FavoriteFood>> fetchAllFavoriteFoods() async{
    final response = await http.get(Uri.parse(apiUrl));
    if(response.statusCode == 200){
      List<dynamic> body = json.decode(response.body);
      List<FavoriteFood> favoriteFoods = body.map((dynamic item) => FavoriteFood.fromJson(item)).toList();
      return favoriteFoods;
    }else{
      throw Exception("Failed to load favorite foods");
    }
  }
  
  Future<FavoriteFood> getFavoriteFoodByProduct(int product_id) async{
    final response = await http.get(Uri.parse('$apiUrl/getfavoritefoodbyproduct?email=$email&product_id=$product_id'));
    if(response.statusCode == 200){
      return FavoriteFood.fromJson(json.decode(response.body));
    }else{
      throw Exception("Failed to load favorite food");
    }
  }
  
  Future<void> deleteFavoriteFood(int favoriteFood_id) async{
    print('$apiUrl/delete?favoriteFood_id=$favoriteFood_id');
    final response = await http.get(Uri.parse('$apiUrl/delete?favoriteFood_id=$favoriteFood_id'));
    if(response.statusCode == 200){
      print("Delete favorite food successfullly");
    }else{
      throw Exception("Failed to delete favorite food");
    }
  }

  Future<void> saveFavoriteFood(FavoriteFood favoriteFood) async{
    final response = await http.post(Uri.parse('$apiUrl/insert'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    body: json.encode(favoriteFood.toJson()));
    if(response.statusCode == 200){
      print("Create favorite food successfully!");
    }else{
      print("Failed to create favorite food");
    }

  }
}