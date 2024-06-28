// import 'dart:ffi';

class Person {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String address;
  final String imageURL;

  Person(
      {required this.fullName,
      required this.email,
      required this.phoneNumber,
      required this.address,
      required this.imageURL});

  factory Person.toJson(Map<String, dynamic> json) {
    return Person(
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      imageURL: json['imageURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'imageURL': imageURL,
    };
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      imageURL: json['imageURL'],
    );
  }
}
