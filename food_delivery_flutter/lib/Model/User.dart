// import 'dart:ffi';

class Person {
  final String? fullName;
  final String? email;
  final String? phoneNumber;
  final String address;
  final String imageURL;
  final String roles;

  Person(
      {required this.fullName,
      required this.email,
      required this.phoneNumber,
      required this.address,
      required this.imageURL, required this.roles});

  factory Person.toJson(Map<String, dynamic> json) {
    return Person(
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      imageURL: json['imageURL'],
      roles: json['roles'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'imageURL': imageURL,
      'roles': roles,
    };
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      imageURL: json['imageURL'],
      roles: json['roles'],
    );
  }
}
