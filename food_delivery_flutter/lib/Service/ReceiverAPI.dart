import 'dart:convert';

import 'package:food_delivery/Model/Receiver.dart';
import 'package:http/http.dart' as http;

class ReceiverSerice {
  String apiUrl = "http://192.168.1.4:8080/api/receiver";

  Future<void> insertReceiver(Receiver receiver) async{
    final response = await http.post(Uri.parse('$apiUrl/insert'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
        body: jsonEncode(receiver.toJson()));
    if (response.statusCode == 200){
      print("Create receiver successfully!");
    }else{
      throw Exception("Failed to create receiver");
    }
  }
}