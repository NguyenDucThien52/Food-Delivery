import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Model/User.dart';
import 'package:food_delivery/Service/CartAPI.dart';
import 'package:food_delivery/Service/OrderAPI.dart';
import 'package:food_delivery/Service/UserAPI.dart';
import 'package:food_delivery/View/Page/Cart_page.dart';
import 'package:food_delivery/View/Page/Other.dart';
import 'package:food_delivery/View/Page/Home.dart';
import 'package:food_delivery/View/Page/shop.dart';

import '../../Model/Cart.dart';
import '../../Model/Order.dart';

class Home_page extends StatefulWidget {
  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  var selectedIndex = 0;
  late Future<Cart> cartF;
  late Cart cart;
  late Person user;
  late Future<Person> person;
  late List<Order> orders;

  @override
  void initState() {
    super.initState();
    cartF = CartService().fetchCart();
    person = UserService().getUser(FirebaseAuth.instance.currentUser!.email);
    person.then((value) {
      user =
          Person(email: value.email, phoneNumber: value.phoneNumber, address: value.address, fullName: value.fullName, imageURL: value.imageURL);
    });
    cartF.then((value) {
      cart = Cart(cart_id: value.cart_id, email: value.email);
    });
    OrderService().fetchOrder().then((value) {
      orders = value;
    });
    print("Hello");
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = Home();
      case 1:
        page = Shop_page();
      case 2:
        page = Other(cart: cart);
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
        future: cartF,
        builder: (context, snapshot) {
          return Scaffold(
            body: mainArea,
            floatingActionButton: FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Cart_page(cart_id: snapshot.data!.cart_id, user: user)));
              },
              child: const Icon(Icons.shopping_cart, size: 28),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              fixedColor: Theme.of(context).colorScheme.primary,
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
                  icon: Icon(Icons.list_outlined),
                  label: "Khác",
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
        });
  }
}
