import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Shopping extends StatefulWidget {
  @override
  State<Shopping> createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  // late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    // products = ProductAPI().fetchProducts();
  }

  final List<Map<String, String>> products = [
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
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 200,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(10.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductItem(
                    name: products[index]["name"]!,
                    imageUrl: products[index]["image"]!,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String name;
  final String imageUrl;

  ProductItem({required this.name, required this.imageUrl});

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