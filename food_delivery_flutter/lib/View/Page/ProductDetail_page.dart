import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Model/CartItem.dart';
import 'package:food_delivery/Model/Review.dart';
import 'package:food_delivery/Service/CartItemAPI.dart';
import 'package:food_delivery/Service/ReviewAPI.dart';

import '../../Model/Cart.dart';
import '../../Model/Product.dart';

class ProductDetail_page extends StatefulWidget {
  final Product product;
  final Cart? cart;

  const ProductDetail_page({super.key, required this.product, required this.cart});

  @override
  State<ProductDetail_page> createState() => _ProductDetail_pageState();
}

class _ProductDetail_pageState extends State<ProductDetail_page> {
  late Future<List<Review>> review;

  @override
  void initState() {
    super.initState();
    review = ReviewService().fetchReviews(widget.product.product_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết sản phẩm"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.product.imageURL,
            fit: BoxFit.cover,
          ),
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          widget.product.name,
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "${widget.product.price} đ",
                          style: TextStyle(fontSize: 20),
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          "Mô tả",
                          style: TextStyle(fontSize: 20),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_border),
                    ),
                    Row(
                      children: [
                        FutureBuilder<List<Review>>(
                            future: review,
                            builder: (context, snapshot) {
                              int rate = 0;
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData) {
                                return Center(child: Text('No orders found.'));
                              } else {
                                for (int i = 0; i < snapshot.data!.length; i++) {
                                  rate += snapshot.data![i].rating;
                                }
                                return Text('(${snapshot.data!.length}) ${rate / snapshot.data!.length}');
                              }
                            }),
                        IconButton(onPressed: () {}, icon: Icon(Icons.star)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text(widget.product.description)),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer, side: BorderSide()),
        onPressed: () {
          int cartItemid = DateTime.now().millisecondsSinceEpoch;
          CartItemService().fetchCartItem(widget.product.product_id, widget.cart!.cart_id).then((value) {
            if (value.quantity == 0) {
              CartItemService().saveCartItem(CartItem(
                  cart_id: widget.cart!.cart_id,
                  quantity: 1,
                  product_id: widget.product.product_id,
                  cartItem_id: cartItemid));
            } else {
              CartItemService().saveCartItem(CartItem(
                  cart_id: widget.cart!.cart_id,
                  quantity: (value.quantity + 1),
                  product_id: widget.product.product_id,
                  cartItem_id: value.cartItem_id));
            }
          });
        },
        child: Text("Đặt hàng"),
      ),
    );
  }
}
