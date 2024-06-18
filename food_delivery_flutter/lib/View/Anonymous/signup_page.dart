import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:food_delivery/Model/Cart.dart';
import 'package:food_delivery/Model/User.dart';
import 'package:food_delivery/Service/CartAPI.dart';

import 'package:food_delivery/Service/UserAPI.dart';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:food_delivery/View/Anonymous/login_page.dart';

// import 'package:flutter/painting.dart';
// import 'package:flutter/widgets.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormFieldState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _passowrdKey = GlobalKey<FormFieldState>();
  final _confirmpasswordKey = GlobalKey<FormFieldState>();
  final _phoneKey = GlobalKey<FormFieldState>();
  String errorMessage = '';

  var id = Random().nextInt(1000);
  final UserService userService = UserService();
  final CartService cartService = CartService();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView(
        children: [
          Text(
            "Food Delivery",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Text(
              "Đăng ký",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 340,
                        height: 30,
                        child: RichText(
                          text: TextSpan(
                            text: "Họ và tên",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                            children: [
                              TextSpan(
                                text: "*",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextFormField(
                        key: _nameKey,
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onChanged: (value) {
                          _nameKey.currentState!.validate();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Tên không được phép để trống";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      SizedBox(
                        width: 340,
                        height: 30,
                        child: RichText(
                          text: TextSpan(
                            text: "Email",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                            children: [
                              TextSpan(
                                text: "*",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextFormField(
                        key: _emailKey,
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onChanged: (value) {
                          _emailKey.currentState!.validate();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email không được phép bỏ trống";
                          } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                            return "Không đúng định dạng của mail! Vui lòng nhập lại";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      SizedBox(
                        width: 340,
                        height: 30,
                        child: RichText(
                          text: TextSpan(
                            text: "Mật khẩu",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                            children: [
                              TextSpan(
                                text: "*",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextFormField(
                        key: _passowrdKey,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onChanged: (value) {
                          _passowrdKey.currentState!.validate();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Mật khẩu không được phép bỏ trống";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      SizedBox(
                        width: 340,
                        height: 30,
                        child: RichText(
                          text: TextSpan(
                            text: "Xác nhận mật khẩu",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                            children: [
                              TextSpan(
                                text: "*",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextFormField(
                        key: _confirmpasswordKey,
                        controller: _confirmpasswordController,
                        decoration: InputDecoration(
                          hintText: "confirm password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Xác nhận mật khẩu không được phép bỏ trống";
                          } else if (value.toString() != _passwordController.text) {
                            return "Không trung với mật khẩu! Vui lòng nhập lại";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      SizedBox(
                        width: 340,
                        height: 30,
                        child: Text(
                          "Số điện thoại",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextFormField(
                        key: _phoneKey,
                        controller: _phoneController,
                        decoration: InputDecoration(
                          hintText: "Phone number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onChanged: (value) => {_phoneKey.currentState!.validate()},
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            try {
                              double.parse(value.toString());
                              return null;
                            } catch (e) {
                              return "Không nhập đúng định dạng số! Vui lòng nhập lại";
                            }
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 320,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            _passwordController.text == _confirmpasswordController.text) {
                          register();
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primaryContainer)),
                      child: Text("Đăng ký"),
                    ),
                  ),
                  SizedBox(height: 15),
                  RichText(
                    text: TextSpan(
                      text: "Bạn đã có tài khoản? ",
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Đăng nhập",
                          style: TextStyle(
                              decoration: TextDecoration.underline, color: Theme.of(context).colorScheme.primary),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> register() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      userService.registerUser(
        Person(
            fullName: _nameController.text,
            email: _emailController.text,
            address: 'Le Thanh Nghi, Hai Ba Trung, Ha Noi',
            passwowrd: _passwordController.text,
            phoneNumber: _phoneController.text),
      );
      cartService.saveCart(Cart(cart_id: DateTime.now().millisecondsSinceEpoch, email: _emailController.text, cartItem_id: []));

      print("Registered user: ${userCredential.user}");
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
      print('Registration failed: $errorMessage');
    }
  }
}
