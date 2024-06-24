import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:food_delivery/Model/Product.dart';

class ProductService {
  final String apiUrl = "http://192.168.1.4:8080/api/products";

  Future<List<Product>> fetchProducts() async {
    print(apiUrl);
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      List<Product> products = body.map((dynamic item) => Product.fromJson(item)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Product>> getProductsByCartItem(List<int> product_id) async{
    String numberString = product_id.join(',');
    print('$apiUrl/getProductByCart?product_id=$numberString');
    final response = await http.get(Uri.parse('$apiUrl/getProductByCart?product_id=$numberString'));
    if(response.statusCode == 200){
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      List<Product> products = body.map((dynamic item) => Product.fromJson(item)).toList();
      return products;
    }else{
      throw Exception("Failed to load products");
    }
  }

  Future<int> insertProducts(Product product) async {
    print('$apiUrl/insert');
    final response = await http.post(
      Uri.parse('$apiUrl/insert'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(product.toJson()),
    );
    if (response.statusCode == 200) {
      return int.parse(response.body);
    }else{
      throw Exception('Failed to add product');
    }
  }
}
