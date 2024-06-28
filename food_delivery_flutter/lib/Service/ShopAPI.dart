import 'dart:convert';

import 'package:food_delivery/Model/Shop.dart';

import 'package:http/http.dart' as http;

class ShopService{
  final String apiUrl = "http://192.168.1.4:8080/api/shops";

  Future<List<Shop>> fetchShop() async{
    final response = await http.get(Uri.parse(apiUrl));
    if(response.statusCode == 200){
      List<dynamic> body =  json.decode(utf8.decode(response.bodyBytes));
      List<Shop> shops = body.map((dynamic item) => Shop.fromJson(item)).toList();
      return shops;
    }else{
      throw Exception("Failed to load shops");
    }
  }
}