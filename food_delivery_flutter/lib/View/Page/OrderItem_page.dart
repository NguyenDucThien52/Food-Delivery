import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Model/Order.dart';
import 'package:food_delivery/Service/OrderAPI.dart';
import 'package:food_delivery/Service/OrderItemAPI.dart';
import 'package:food_delivery/Service/ProductAPI.dart';

import '../../Model/OrderItem.dart';
import '../../Model/Product.dart';
import '../../Model/Review.dart';
import '../../Service/ReviewAPI.dart';

class OrderItem_page extends StatefulWidget {
  final Order order;

  const OrderItem_page({required this.order});

  @override
  State<OrderItem_page> createState() => _OrderItem_pageState();
}

class _OrderItem_pageState extends State<OrderItem_page> {
  late Future<List<OrderItem>> orderitems;
  late Future<List<Product>> products;
  late Future<Review> review;
  List<int> product_id = [];
  int rate = 0;

  void _showPopUpRate(BuildContext context, Future<Review> review, Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<Review>(
          future: review,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return Center(child: Text('No products found in orderitem'));
            } else {
              return RateDialog(
                reivew: snapshot.data,
                product: product,
              );
            }
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    products = Future.value([]);
    orderitems = OrderItemService().fetchOrderItems(widget.order.order_id);
    orderitems.then((value) {
      for (int i = 0; i < value.length; i++) {
        product_id.add(value[i].product_id);
      }
      setState(() {
        products = ProductService().getProductsByCartItem(product_id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết đơn hàng"),
      ),
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No products found in cart'));
          } else {
            print("Hello");
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Product product = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      product.imageURL,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(product.price.toStringAsFixed(0))
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        review = ReviewService().getReviewByEmailandProduct(product.product_id);
                        _showPopUpRate(context, review, product);
                      },
                      icon: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: Padding(padding: EdgeInsets.symmetric(vertical: 15),child: ElevatedButton(onPressed:(){
        OrderService().insertOrder(Order(order_id: widget.order.order_id, totalAmount: widget.order.totalAmount, quantity: widget.order.quantity, orderDate: widget.order.orderDate, deliveryAddress: widget.order.deliveryAddress, paymentMethod: widget.order.paymentMethod, email: widget.order.email, receiver_id: widget.order.receiver_id, order_Status: "Đã giao hàng"));
        Navigator.pop(context);
        Navigator.pop(context);
      },child: Text("Xác nhận đã chuyển đơn hàng thành công"), style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primaryContainer),)),
    );
  }
}

class RateDialog extends StatefulWidget {
  Review? reivew;
  Product product;

  RateDialog({required this.reivew, required this.product});

  @override
  State<RateDialog> createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {
  late int rate;

  @override
  void initState() {
    super.initState();
    rate = widget.reivew!.rating;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Đánh giá",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: SizedBox(
        height: 75,
        child: Column(
          children: [
            Text(
              "Đánh giá món ${widget.product.name}",
              style: TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      rate = 1;
                    });
                  },
                  icon: rate >= 1 ? Icon(Icons.star) : Icon(Icons.star_border),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        rate = 2;
                      });
                    },
                    icon: rate >= 2 ? Icon(Icons.star) : Icon(Icons.star_border)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        rate = 3;
                      });
                    },
                    icon: rate >= 3 ? Icon(Icons.star) : Icon(Icons.star_border)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        rate = 4;
                      });
                    },
                    icon: rate >= 4 ? Icon(Icons.star) : Icon(Icons.star_border)),
                IconButton(
                    onPressed: () {
                      setState(() {
                        rate = 5;
                      });
                    },
                    icon: rate >= 5 ? Icon(Icons.star) : Icon(Icons.star_border)),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            ReviewService().getReviewByEmailandProduct(widget.product.product_id).then((value) {
              if (value.email=="") {
                ReviewService().insertReview(Review(
                    review_id: DateTime
                        .now()
                        .millisecondsSinceEpoch,
                    rating: rate,
                    email: FirebaseAuth.instance.currentUser!.email,
                    product_id: widget.product.product_id));
              }else if(value.rating != rate){
                ReviewService().insertReview(Review(
                    review_id: value.review_id,
                    rating: rate,
                    email: FirebaseAuth.instance.currentUser!.email,
                    product_id: widget.product.product_id));
              }
            });
            Navigator.pop(context);
          },
          child: Text("Xác nhận"),
        ),
      ],
    );
  }
}
