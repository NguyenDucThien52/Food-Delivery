import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Model/User.dart';
import 'package:food_delivery/Service/CartAPI.dart';
import 'package:food_delivery/Service/UserAPI.dart';
import 'package:food_delivery/View/Page/Cart_page.dart';
import 'package:food_delivery/View/Page/home.dart';
import 'package:food_delivery/View/Page/shop.dart';

import '../../Model/Cart.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;
  late Future<Cart> cart;
  late Person user;
  late Future<Person> person;

  @override
  void initState(){
    super.initState();
    cart = CartService().fetchCart();
    person = UserService().getUser(FirebaseAuth.instance.currentUser!.email);
    person.then((value) {
      user = Person(email: value.email, phoneNumber: value.phoneNumber, address: value.address, fullName: value.fullName);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = Home();
      case 1:
        page = Shop();
      case 2:
        page = Placeholder();
      case 3:
        page = Placeholder();
      case 4:
        page = Placeholder();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    var mainArea = ColoredBox(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );
    return FutureBuilder<Cart>(
      future: cart,
      builder:(context, snapshot) {
        return Scaffold(
          body: mainArea,
          // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: FloatingActionButton(
            // backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
            // tooltip: 'Increment',
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Cart_page(cart_id: snapshot.data!.cart_id, user: user)));
            },
            child: const Icon(Icons.shopping_cart, size: 28),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme
                .of(context)
                .colorScheme
                .primaryContainer,
            fixedColor: Theme
                .of(context)
                .colorScheme
                .primary,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Trang chủ",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.store),
                label: "Cửa hàng",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard),
                label: "Ưu đãi",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_outlined),
                label: "Khác",
                // backgroundColor: Colors.lightGreen,
              ),
            ],
            currentIndex: selectedIndex,
            onTap: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
          ),
        );
      }
    );
  }
}
