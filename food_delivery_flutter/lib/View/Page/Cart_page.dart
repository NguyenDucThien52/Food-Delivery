import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Service/CartAPI.dart';
import 'package:food_delivery/Service/ProductAPI.dart';

import '../../Model/Product.dart';
import '../../Model/Cart.dart';

class Cart_page extends StatefulWidget {
  @override
  State<Cart_page> createState() => _Cart_pageState();
}

class _Cart_pageState extends State<Cart_page> {
  late Future<Cart> carts;

  @override
  void initState() {
    super.initState();
    carts = CartService().fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Cart>(
                future: carts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: ListTile(
                            leading: Image.network(
                              "https://loremflickr.com/320/240/foods?random=1",
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data!.cart_id.toString()),
                              ],
                            ),
                            trailing: SizedBox(
                              width: 80,
                              child: Row(
                                children: [
                                  Icon(Icons.remove),
                                  Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8),
                                      child: Text(
                                        "1",
                                        style: TextStyle(fontSize: 17),
                                      )),
                                  Icon(
                                    Icons.add,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
