import 'dart:convert';

import 'package:food_delivery/Model/Category.dart';
import 'package:http/http.dart' as http;

class CategoryService{
  final String apiUrl = "http://192.168.1.4:8080/api/categories";

  Future<List<Category>> fetchCategory() async{
    final response = await http.get(Uri.parse(apiUrl));
    if(response.statusCode == 200){
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      List<Category> categories = body.map((dynamic item) => Category.fromJson(item)).toList();
      return categories;
    }else{
      throw Exception("Failed to load categories");
    }
  }
}