import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:food_delivery/Model/Product.dart';

class ProductAPI {
  final String apiUrl = "http://192.168.1.5:8080/api/products";

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      List<Product> products = body.map((dynamic item) => Product.fromJson(item)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<void> insertProducts(Product product) async {
    final response = await http.post(
      Uri.parse('$apiUrl + insert'),
      body: jsonEncode(product.toJson()),
    );
    if (response.statusCode == 200) {}
  }
}
