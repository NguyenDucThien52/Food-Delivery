import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:food_delivery/Model/Product.dart';

class ProductAPI {
  final String apiUrl = "http://192.168.50.137:8080/api/products";

  Future<List<Product>> fetchProducts() async {
    print("Hello world");
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> body = json.decode(response.body);
      print(body[1]);
      List<Product> products = body.map((dynamic item) => Product.fromJson(item)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
