import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Service/CartAPI.dart';
import 'package:food_delivery/Service/ProductAPI.dart';

import '../../Model/Cart.dart';
import '../../Model/Product.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Product>> products;
  late Future<Cart> cart;

  @override
  void initState() {
    super.initState();
    cart = CartService().fetchCart();
    products = ProductService().fetchProducts();
  }

  final List<Map<String, String>> productss = [
    {"name": "Product 1", "image": "https://via.placeholder.com/150"},
    {"name": "Product 2", "image": "https://via.placeholder.com/150"},
    {"name": "Product 3", "image": "https://via.placeholder.com/150"},
    {"name": "Product 4", "image": "https://via.placeholder.com/150"},
    {"name": "Product 5", "image": "https://via.placeholder.com/150"},
    {"name": "Product 6", "image": "https://via.placeholder.com/150"},
    {"name": "Product 7", "image": "https://via.placeholder.com/150"},
    {"name": "Product 8", "image": "https://via.placeholder.com/150"},
    {"name": "Product 9", "image": "https://via.placeholder.com/150"},
  ];

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
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 200,
                                    child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      padding: EdgeInsets.all(10.0),
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                      ),
                                      itemCount: productss.length,
                                      itemBuilder: (context, index) {
                                        return ProductItem(
                                          name: productss[index]["name"]!,
                                          imageUrl: productss[index]["image"]!,
                                        );
                                      },
                                    ),
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
                                                    "https://loremflickr.com/320/240/foods?random=1",
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
                                                                List<int>? product_id = cartSnapshot.data!.product_id;
                                                                product_id.add(product.product_id);
                                                                print(product_id);
                                                                CartService().saveCart(Cart(cart_id: cartSnapshot.data!.cart_id, email: cartSnapshot.data!.email, product_id: product_id));
                                                              },
                                                              icon: Icon(
                                                                Icons.add_circle_outline,
                                                                size: 35,
                                                              ),
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
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Card(
                                            color: Theme
                                                .of(context)
                                                .colorScheme
                                                .background,
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
                                                  Text(snapshot.data![i].name),
                                                  Text(
                                                    snapshot.data![i].description,
                                                    style: TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                              trailing: Text(snapshot.data![i].price.toString()),
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
                      }
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String name;
  final String imageUrl;

  const ProductItem({required this.name, required this.imageUrl});

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
            style: TextStyle(fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
