import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/Model/Review.dart';
import 'package:http/http.dart' as http;

class ReviewService{
  final String apiUrl = "http://192.168.1.4:8080/api/reviews";
  final String? email = FirebaseAuth.instance.currentUser!.email;

  Future<List<Review>> fetchReviews(int product_id) async{
    final response = await http.get(Uri.parse('$apiUrl?product_id=$product_id'));
    if(response.statusCode == 200){
      List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      List<Review> reviews = body.map((dynamic item) => Review.fromJson(item)).toList();
      return reviews;
    }else{
      throw Exception("Failed to load reviews");
    }
  }
  
  Future<Review> getReviewByEmailandProduct(int product_id) async{
    final response = await http.get(Uri.parse('$apiUrl/getreviewbyproductandemail?product_id=$product_id&email=$email'));
    if(response.statusCode == 200){
      Review review = Review.fromJson(json.decode(response.body));
      print(review.email);
      return review;
    }else{
      throw Exception("Failed to load review by email and product");
    }
  }

  Future<void> insertReview(Review review) async{
    final response = await http.post(Uri.parse('$apiUrl/insert'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    body: json.encode(review.toJson()));
    if(response.statusCode == 200){
      print("Create review successfully!");
    }else{
      throw Exception("Failed to create review");
    }

  }
}