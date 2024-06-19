import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Service/CartAPI.dart';
import 'package:food_delivery/Service/CartItemAPI.dart';
import 'package:food_delivery/Service/ProductAPI.dart';
import 'package:food_delivery/View/Page/home_page.dart';

import '../../Model/CartItem.dart';
import '../../Model/Product.dart';
import '../../Model/Cart.dart';

class Cart_page extends StatefulWidget {
  final int cart_id;

  Cart_page({required this.cart_id});

  @override
  State<Cart_page> createState() => _Cart_pageState();
}

class _Cart_pageState extends State<Cart_page> {
  late Future<List<Product>> products;
  late Future<List<CartItem>> cartItems;
  List<int> product_id = [];

  @override
  void initState() {
    super.initState();
    products = Future.value([]);
    cartItems = CartItemService().fetchCartItemByCart(widget.cart_id);
    cartItems.then((cartData) {
      for (CartItem item in cartData) {
        product_id.add(item.product_id);
      }
      setState(() {
        products = ProductService().getProductsByCart(product_id);
      });
    });
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
            child: FutureBuilder<List<CartItem>>(
                future: cartItems,
                builder: (context, cartItemSnapshot) {
                  return FutureBuilder<List<Product>>(
                    future: products,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No products found in cart'));
                      } else {
                        return Column(
                          children: [
                            SizedBox(
                              height: 700,
                              child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  CartItem cartItem = cartItemSnapshot.data![index];
                                  Product product = snapshot.data![index];
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
                                          Text(product.name.toString()),
                                        ],
                                      ),
                                      trailing: SizedBox(
                                        width: 110,
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  if (cartItem.quantity > 1) {
                                                    setState(() {
                                                      CartItemService().saveCartItem(CartItem(
                                                          cart_id: cartItem.cart_id,
                                                          quantity: (cartItem.quantity - 1),
                                                          product_id: product.product_id,
                                                          cartItem_id: cartItem.cartItem_id));
                                                    });
                                                  } else {
                                                    setState(() {
                                                      CartItemService().deleteCartItem(cartItem.cartItem_id);
                                                    });
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.remove,
                                                  color: Colors.blue,
                                                )),
                                            Text(
                                              cartItem.quantity.toString(),
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  CartItemService().saveCartItem(CartItem(
                                                      cart_id: cartItem.cart_id,
                                                      quantity: (cartItem.quantity + 1),
                                                      product_id: product.product_id,
                                                      cartItem_id: cartItem.cartItem_id));
                                                },
                                                icon: Icon(
                                                  Icons.add,
                                                  color: Colors.blue,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
