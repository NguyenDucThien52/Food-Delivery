import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/View/Anonymous/signup_page.dart';
import 'package:food_delivery/View/Page/admin.dart';
import 'package:food_delivery/View/Page/Home.dart';
import 'package:food_delivery/View/Page/Home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool obscureText = true; // show/hide password

  // Validate
  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();

  FocusNode userName = FocusNode();

  @override
  Widget build(BuildContext context) {
    userName.addListener(() {
      !_formKey.currentState!.validate();
    });
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/Peach_Iced_Tea.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: const SizedBox(width: 500)),
            Expanded(
              flex: 2,
              child: Card(
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      Text(
                        "Chào mừng bạn đến với",
                      ),
                      Text(
                        "Food Delivery",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                key: _emailKey,
                                controller: _emailController,
                                decoration: InputDecoration(
                                    hintText: "Email",
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Tài khoản không được phép trống!';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  _emailKey.currentState!.validate();
                                },
                              ),
                              SizedBox(width: 280, height: 20),
                              TextFormField(
                                key: _passwordKey,
                                controller: _passwordController,
                                obscureText: obscureText,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      obscureText ? Icons.visibility : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(
                                        () {
                                          obscureText = !obscureText;
                                        },
                                      );
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Mật khẩu không được phép trống!';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  _passwordKey.currentState!.validate();
                                },
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    login();
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(Theme.of(context).colorScheme.primaryContainer),
                                  fixedSize: MaterialStateProperty.all<Size>(Size(310, 50)),
                                ),
                                child: Text("Đăng nhập"),
                              ),
                              const SizedBox(height: 15),
                              RichText(
                                text: TextSpan(
                                  text: "Bạn chưa có tài khoản? ",
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: "Đăng ký",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Theme.of(context).colorScheme.primary),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SignUpPage(),
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
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool validate(String value) {
    if (value.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      setState(() {
        _emailController.text = "";
        _passwordController.text = "";
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home_page()));
    } catch (e) {
      print(e);
    }
  }
}
