import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Service/CartAPI.dart';
import 'package:food_delivery/Service/CartItemService.dart';
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
  // late Future<Cart> cart;
  late Future<List<Product>> products;
  late Future<List<CartItem>> cartItems;
  List<int> product_id = [];

  @override
  void initState() {
    super.initState();
    // Khởi tạo products từ initState bằng cách gọi hàm getProductsByCart.
    products = Future.value([]);
    cartItems = CartItemService().fetchCartItemByCart(widget.cart_id);
    cartItems.then((cartData) {
      for(CartItem item in cartData){
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
                              Text(product.name.toString()),
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