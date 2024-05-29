import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Service/ProductAPI.dart';

import '../../Model/Product.dart';

// class Product {
//   final String name;
//   final String imageUrl;
//   final String description;
//   final double price;
//
//   Product({required this.name, required this.imageUrl, required this.description, required this.price});
// }

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = ProductAPI().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: TabBar(
            tabs: [
              Tab(text: 'Coffee', icon: Icon(Icons.coffee)),
              Tab(text: 'Tea', icon: Icon(Icons.local_drink)),
              Tab(text: 'Juice', icon: Icon(Icons.local_bar)),
              Tab(text: 'Cake', icon: Icon(Icons.cake)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: FutureBuilder<List<Product>>(
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
                          height: 350, // Đặt chiều cao cho ListView
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
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            product.name,
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                          child: Text(
                                            '\$${product.price!.toStringAsFixed(2)}',
                                            style: TextStyle(fontSize: 16, color: Colors.grey),
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
                                  color: Theme.of(context).colorScheme.background,
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
              ),
            ),
            Center(child: Text('Tea Page')),
            Center(child: Text('Juice Page')),
            Center(child: Text('Cake Page')),
          ],
        ),
      ),
            ),
    );
  }
}
