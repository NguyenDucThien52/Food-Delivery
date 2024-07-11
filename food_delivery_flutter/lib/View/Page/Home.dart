import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Model/CartItem.dart';
import 'package:food_delivery/Model/Category.dart';
import 'package:food_delivery/Service/CartAPI.dart';
import 'package:food_delivery/Service/CartItemAPI.dart';
import 'package:food_delivery/Service/CategoryAPI.dart';
import 'package:food_delivery/Service/ProductAPI.dart';
import 'package:food_delivery/View/Page/Category_page.dart';
import 'package:food_delivery/View/Page/ProductDetail_page.dart';
import 'package:food_delivery/View/Page/Search.dart';

import '../../Model/Cart.dart';
import '../../Model/Product.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Product>> products;
  late Future<Cart> cart;
  late Future<List<Category>> categories;

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Bạn đã thêm thành công sản phẩm vào giỏ hàng!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    cart = CartService().fetchCart();
    products = ProductService().fetchProducts();
    categories = CategoryService().fetchCategory();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: FutureBuilder<Cart>(
                      future: cart,
                      builder: (context, cartSnapshot) {
                        return FutureBuilder<List<Product>>(
                          future: products,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error} 1'));
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Xin chao ${FirebaseAuth.instance.currentUser!.displayName}"),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.background,
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black87.withOpacity(0.2),
                                                blurRadius: 2,
                                              )
                                            ],
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context, MaterialPageRoute(builder: (context) => Search()));
                                            },
                                            icon: Icon(
                                              Icons.search_rounded,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 200,
                                    child: FutureBuilder(
                                        future: categories,
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return Center(child: CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return Center(child: Text('Error: ${snapshot.error}'));
                                          } else {
                                            return GridView.builder(
                                              itemCount: snapshot.data!.length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => Category_page(
                                                                category: snapshot.data![index],
                                                                cart: cartSnapshot.data)));
                                                  },
                                                  child: CategoryItem(
                                                      name: snapshot.data![index].name,
                                                      imageUrl: snapshot.data![index].imageURL),
                                                );
                                              },
                                              scrollDirection: Axis.horizontal,
                                              padding: EdgeInsets.all(10.0),
                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                              ),
                                            );
                                          }
                                        }),
                                  ),
                                  SizedBox(
                                    height: 320, // Đặt chiều cao cho ListView
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal, // Thiết lập chiều ngang
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) {
                                        Product product = snapshot.data![index];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Card(
                                            elevation: 4.0,
                                            child: SizedBox(
                                              width: 180, // Đặt chiều rộng cho mỗi Card
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Image.network(
                                                    product.imageURL,
                                                    height: 200,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 116,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.all(10.0),
                                                              child: Text(
                                                                product.name,
                                                                style: TextStyle(
                                                                    fontSize: 16, fontWeight: FontWeight.bold),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                              child: Text(
                                                                '\$${product.price.toStringAsFixed(2)}',
                                                                style: TextStyle(fontSize: 16, color: Colors.grey),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 70,
                                                        width: 50,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            IconButton(
                                                              onPressed: () {
                                                                int cartItemid = DateTime.now().millisecondsSinceEpoch;
                                                                CartItemService()
                                                                    .fetchCartItem(
                                                                        product.product_id, cartSnapshot.data!.cart_id)
                                                                    .then((value) {
                                                                  print(value.quantity);
                                                                  if (value.quantity == 0) {
                                                                    CartItemService().saveCartItem(CartItem(
                                                                        cart_id: cartSnapshot.data!.cart_id,
                                                                        quantity: 1,
                                                                        product_id: product.product_id,
                                                                        cartItem_id: cartItemid));
                                                                  } else {
                                                                    CartItemService().saveCartItem(CartItem(
                                                                        cart_id: cartSnapshot.data!.cart_id,
                                                                        quantity: (value.quantity + 1),
                                                                        product_id: product.product_id,
                                                                        cartItem_id: value.cartItem_id));
                                                                  }
                                                                });
                                                                showSnackBar(context);
                                                              },
                                                              icon: Icon(Icons.add_circle_outline, size: 35),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      "Popular",
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      for (var i = 0; i < snapshot.data!.length; i++)
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => ProductDetail_page(
                                                          product: snapshot.data![i],
                                                          cart: cartSnapshot.data,
                                                        )));
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 10),
                                            child: Card(
                                              color: Theme.of(context).colorScheme.background,
                                              child: ListTile(
                                                leading: Image.network(
                                                  snapshot.data![i].imageURL,
                                                  height: 60,
                                                  width: 60,
                                                  fit: BoxFit.cover,
                                                ),
                                                title: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(snapshot.data![i].name),
                                                    Text(
                                                      snapshot.data![i].price.toString(),
                                                      style: TextStyle(fontSize: 10),
                                                    ),
                                                  ],
                                                ),
                                                trailing: IconButton(
                                                  onPressed: () {
                                                    int cartItemid = DateTime.now().millisecondsSinceEpoch;
                                                    CartItemService()
                                                        .fetchCartItem(
                                                            snapshot.data![i].product_id, cartSnapshot.data!.cart_id)
                                                        .then((value) {
                                                      if (value.quantity == 0) {
                                                        CartItemService().saveCartItem(CartItem(
                                                            cart_id: cartSnapshot.data!.cart_id,
                                                            quantity: 1,
                                                            product_id: snapshot.data![i].product_id,
                                                            cartItem_id: cartItemid));
                                                      } else {
                                                        CartItemService().saveCartItem(CartItem(
                                                            cart_id: cartSnapshot.data!.cart_id,
                                                            quantity: (value.quantity + 1),
                                                            product_id: snapshot.data![i].product_id,
                                                            cartItem_id: value.cartItem_id));
                                                      }
                                                    });
                                                    showSnackBar(context);
                                                  },
                                                  icon: Icon(Icons.add_circle_outline),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                ],
                              );
                            }
                          },
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String name;
  final String imageUrl;

  const CategoryItem({required this.name, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          imageUrl,
          height: 50,
          width: 50,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            style: TextStyle(fontSize: 12.0),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
