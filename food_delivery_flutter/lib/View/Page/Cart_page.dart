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
  late Future<Cart> cart;
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    cart = CartService().fetchCart();
    // Khởi tạo products từ initState bằng cách gọi hàm getProductsByCart.
    products = Future.value([]);
    cart.then((cartData) {
      setState(() {
        products = ProductService().getProductsByCart(cartData.product_id);
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
            child: FutureBuilder<List<Product>>(
              future: products,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No products found in cart'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
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
                              Text(product.name),
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
                                  ),
                                ),
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
              },
            ),
          ),
        ],
      ),
    );
  }
}