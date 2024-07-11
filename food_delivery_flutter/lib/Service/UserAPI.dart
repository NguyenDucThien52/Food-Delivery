import 'dart:convert';
import 'package:food_delivery/Model/User.dart';
import 'package:http/http.dart' as http;

class UserService {
  String apiUrl = 'http://192.168.1.4:8080/api/users';

  Future<void> registerUser(Person person) async {
    final response = await http.post(
      Uri.parse('$apiUrl/insert'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(person.toJson()),
    );

    if (response.statusCode == 200) {
      print("Create account Successfully");
    } else {
      throw Exception('Failed to register user');
    }
  }
  
  Future<Person> getUser(String? email) async{
    final response = await http.get(Uri.parse('$apiUrl?email=$email'));
    if(response.statusCode == 200){
      return Person.fromJson(json.decode(response.body));
    }else{
      throw Exception("Failed to load user");
    }
  }
}
