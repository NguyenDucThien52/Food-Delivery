import 'dart:convert';
import 'package:food_delivery/Model/User.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const String _baseUrl = 'http://192.168.1.5:8080/user/save';

  Future<int> registerUser(Person person) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(person.toJson()),
    );

    if (response.statusCode == 200) {
      return int.parse(response.body); // Assume response.body contains the userId as a string
    } else {
      throw Exception('Failed to register user');
    }
  }
}
