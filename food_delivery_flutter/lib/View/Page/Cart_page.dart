import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Service/CartAPI.dart';
import 'package:food_delivery/Service/CartItemAPI.dart';
import 'package:food_delivery/Service/ProductAPI.dart';
import 'package:food_delivery/View/Page/Order_page.dart';
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
  List<int> quantitys = [];
  double total = 0;

  @override
  void initState() {
    super.initState();
    products = Future.value([]);
    cartItems = CartItemService().fetchCartItemByCart(widget.cart_id);
    cartItems.then((cartData) {
      for (CartItem item in cartData) {
        product_id.add(item.product_id);
        quantitys.add(item.quantity);
      }
      setState(() {
        products = ProductService().getProductsByCart(product_id);
      });
      products.then((productData) {
        for (int i = 0; i < cartData.length; i++) {
          print(cartData[i].quantity.toString() + "  " + productData[i].price.toString());
          total += productData[i].price * cartData[i].quantity;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giỏ hàng", style: TextStyle(fontWeight: FontWeight.bold),),
        // backgroundColor: Colors.transparent,
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
                              height: 600,
                              child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  CartItem cartItem = cartItemSnapshot.data![index];
                                  Product product = snapshot.data![index];
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: ListTile(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                      leading: Image.network(
                                        product.imageURL,
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                      title: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.name.toString(),
                                            style: TextStyle(fontSize: 19),
                                          ),
                                          Text(product.price.toString()),
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
                                                      cartItem.quantity -= 1;
                                                      CartItemService().saveCartItem(CartItem(
                                                          cart_id: cartItem.cart_id,
                                                          quantity: cartItem.quantity,
                                                          product_id: product.product_id,
                                                          cartItem_id: cartItem.cartItem_id));
                                                    });
                                                  } else {
                                                    setState(() {
                                                      snapshot.data!.removeAt(index);
                                                      cartItemSnapshot.data!.removeAt(index);
                                                    });
                                                    CartItemService().deleteCartItem(cartItem.cartItem_id);
                                                  }
                                                  total -= product.price;
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
                                                setState(() {
                                                  cartItem.quantity += 1;
                                                  CartItemService().saveCartItem(CartItem(
                                                      cart_id: cartItem.cart_id,
                                                      quantity: (cartItem.quantity),
                                                      product_id: product.product_id,
                                                      cartItem_id: cartItem.cartItem_id));
                                                  total += product.price;
                                                });
                                              },
                                              icon: Icon(
                                                Icons.add,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                                width: 350,
                                height: 50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [Text(
                                    "Total: $total",
                                    style: TextStyle(fontSize: 20),
                                  ),]
                                )),
                            ElevatedButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Order_page(total: total)));
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => Cart_page(cart_id: snapshot.data!.cart_id)));
                            }, child: Text("Thanh Toán")),
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
