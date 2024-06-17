// import 'dart:ffi';

class Person{
  final String fullName;
  final String email;
  final String phoneNumber;
  final String passwowrd;
  final String address;

  Person({this.fullName='', this. email='', this.phoneNumber='', this.passwowrd='', this.address=''});

  factory Person.toJson(Map<String, dynamic> json){
    return Person(
        fullName: json['fullName'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        passwowrd: json['password'],
        address: json['address'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'passwowrd': passwowrd,
      'address': address,
    };
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      fullName: json['fullName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      passwowrd: json['password'],
      address: json['address'],
    );
  }
}