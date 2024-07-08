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
  
  Future<List<Product>> getProductByCategory(int category_id) async{
    final response = await http.get(Uri.parse('$apiUrl/getProductbyCategory?category_id=$category_id'));
    if(response.statusCode == 200){
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      List<Product> products = body.map((dynamic item) => Product.fromJson(item)).toList();
      return products;
    }else{
      throw Exception("Failed to load products by category");
    }
  }

  Future<Product> getProductById(int product_id) async{
    print('$apiUrl/getProductByid?product_id=$product_id');
    final response = await http.get(Uri.parse('$apiUrl/getProductByid?product_id=$product_id'));
    if(response.statusCode == 200){
      return Product.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    }else{
      throw Exception("Failed to load product");
    }
  }

  Future<void> insertProducts(Product product) async {
    final response = await http.post(
      Uri.parse('$apiUrl/insert'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(product.toJson()),
    );
    if (response.statusCode == 200) {
      print("Create product successfully");
    }else{
      throw Exception('Failed to add product');
    }
  }
  
  Future<List<Product>> getProductbyKeyWord(String keyword) async{
    print('$apiUrl/getProductbyKeyWord?keyword=$keyword');
    final response = await http.get(Uri.parse('$apiUrl/getProductbyKeyWord?keyword=$keyword'));
    if(response.statusCode == 200){
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      List<Product> products = body.map((dynamic item) => Product.fromJson(item)).toList();
      return products;
    }else{
      throw Exception("Failed to load product");
    }
  }
}
