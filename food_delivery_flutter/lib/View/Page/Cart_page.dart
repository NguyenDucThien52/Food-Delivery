import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Service/CartAPI.dart';
import 'package:food_delivery/Service/CartItemAPI.dart';
import 'package:food_delivery/Service/ProductAPI.dart';
import 'package:food_delivery/View/Page/Order_page.dart';
import 'package:food_delivery/View/Page/Home_page.dart';

import '../../Model/CartItem.dart';
import '../../Model/Product.dart';
import '../../Model/Cart.dart';
import '../../Model/User.dart';

class Cart_page extends StatefulWidget {
  final Person user;
  final int cart_id;

  Cart_page({required this.cart_id, required this.user});

  @override
  State<Cart_page> createState() => _Cart_pageState();
}

class _Cart_pageState extends State<Cart_page> {
  late Future<List<Product>> products;
  late Future<List<CartItem>> cartItems;
  late Future<Product> product;
  late List<CartItem> cartItemsList;
  List<Product?> productList = [];
  List<int> product_id = [];
  List<int> quantitys = [];
  double total = 0;

  @override
  void initState() {
    super.initState();
    print(widget.user.email);
    products = Future.value([]);
    cartItems = CartItemService().fetchCartItemByCart(widget.cart_id);
    cartItems.then((cartData) {
      cartItemsList = cartData;
      for (CartItem item in cartData) {
        print(product_id);
        product_id.add(item.product_id);
        quantitys.add(item.quantity);
      }
      products = ProductService().getProductsByCartItem(product_id);
      products.then((productData) {
        productList = productData;
        for (int i = 0; i < cartData.length; i++) {
          setState(() {
            total += productData[i].price * cartData[i].quantity;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Giỏ hàng,",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<CartItem>>(
              future: cartItems,
              builder: (context, cartItemSnapshot) {
                if (cartItemSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (cartItemSnapshot.hasError) {
                  return Center(child: Text('Error: ${cartItemSnapshot.error}'));
                } else if (!cartItemSnapshot.hasData || cartItemSnapshot.data!.isEmpty) {
                  return Center(child: Text('Không tìm thấy sản phẩm trong giỏ hàng'));
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: 650,
                        child: ListView.builder(
                          itemCount: cartItemSnapshot.data!.length,
                          itemBuilder: (context, index) {
                            product = ProductService().getProductById(cartItemSnapshot.data![index].product_id);
                            return FutureBuilder<Product>(
                              future: product,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(child: Text('Error: ${snapshot.error}'));
                                } else if (!snapshot.hasData) {
                                  return Center(child: Text('Không tìm thấy sản phẩm trong giỏ hàng'));
                                } else {
                                  // productList.add(snapshot.data);
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: 20),
                                          child: ListTile(
                                            contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                            leading: Image.network(
                                              snapshot.data!.imageURL,
                                              height: 60,
                                              width: 60,
                                              fit: BoxFit.cover,
                                            ),
                                            title: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                // Text(cartItemSnapshot.data![index].product_id.toString()),
                                                Text(snapshot.data!.name.toString(), style: TextStyle(fontSize: 19)),
                                                Text(snapshot.data!.price.toString()),
                                              ],
                                            ),
                                            trailing: SizedBox(
                                              width: 110,
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                        if (cartItemSnapshot.data![index].quantity > 1) {
                                                          setState(() {
                                                            cartItemSnapshot.data![index].quantity -= 1;
                                                            CartItemService().saveCartItem(CartItem(
                                                                cart_id: cartItemSnapshot.data![index].cart_id,
                                                                quantity: cartItemSnapshot.data![index].quantity,
                                                                product_id: snapshot.data!.product_id,
                                                                cartItem_id:
                                                                    cartItemSnapshot.data![index].cartItem_id));
                                                          });
                                                        } else {
                                                          CartItemService().deleteCartItem(
                                                              cartItemSnapshot.data![index].cartItem_id);
                                                          setState(() {
                                                            // snapshot.data!.removeAt(index);
                                                            cartItemSnapshot.data!.removeAt(index);
                                                            productList.removeAt(index);
                                                          });
                                                        }
                                                        total -= snapshot.data!.price;
                                                      },
                                                      icon: Icon(
                                                        Icons.remove,
                                                        color: Colors.blue,
                                                      )),
                                                  Text(
                                                    cartItemSnapshot.data![index].quantity.toString(),
                                                    style: TextStyle(fontSize: 17),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        cartItemSnapshot.data![index].quantity += 1;
                                                        CartItemService().saveCartItem(CartItem(
                                                            cart_id: cartItemSnapshot.data![index].cart_id,
                                                            quantity: (cartItemSnapshot.data![index].quantity),
                                                            product_id: snapshot.data!.product_id,
                                                            cartItem_id: cartItemSnapshot.data![index].cartItem_id));
                                                        total += snapshot.data!.price;
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
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(
                          width: 350,
                          height: 50,
                          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                            Text(
                              "Total: $total",
                              style: TextStyle(fontSize: 20),
                            ),
                          ])),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Order_page(
                                        total: total,
                                        user: widget.user,
                                        cartItemsList: cartItemsList,
                                        productList: productList)));
                          },
                          child: Text("Thanh Toán")),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
