import 'package:food_delivery/Model/Product.dart';

class Person{
  final int? user_id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String passwowrd;
  final String address;

  Person({this.user_id, this.fullName='', this. email='', this.phoneNumber='', this.passwowrd='', this.address=''});

  factory Person.toJson(Map<String, dynamic> json){
    return Person(
        user_id: json['user_id'],
        fullName: json['fullName'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        passwowrd: json['password'],
        address: json['address'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'passwowrd': passwowrd,
      'address': address,
    };
  }

  // Optional: Phương thức fromJson để tạo đối tượng User từ JSON
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      user_id: json['user_id'],
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      passwowrd: json['password'],
      address: json['address'],
    );
  }
}