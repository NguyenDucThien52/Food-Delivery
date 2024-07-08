import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Model/User.dart';
import 'package:food_delivery/View/Page/OrderHistory.dart';
import 'package:food_delivery/View/Page/Profile.dart';

import '../../Model/Cart.dart';
import '../../Model/Order.dart';
import 'FavoriteFood.dart';

class Other extends StatefulWidget {
  final Cart cart;

  const Other({required this.cart});

  @override
  State<Other> createState() => _OtherState();
}

class _OtherState extends State<Other> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Center(
          child: Text("Khác"),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Các tiện ích",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => OrderHistory()));
              },
              child: Card(
                color: Theme.of(context).colorScheme.background,
                child: ListTile(
                  leading: Icon(Icons.history),
                  title: Text("Lịch sử đơn hàng"),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
              },
              child: Card(
                color: Theme.of(context).colorScheme.background,
                child: ListTile(
                  leading: Icon(Icons.info_rounded),
                  title: Text("Thông tin cá nhân"),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteFood_page(cart:widget.cart)));
              },
              child: Card(
                color: Theme.of(context).colorScheme.background,
                child: ListTile(
                  leading: Icon(Icons.favorite),
                  title: Text("Đồ ăn ưa thích"),
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
              child: Card(
                color: Theme.of(context).colorScheme.background,
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text("Đăng xuất"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
