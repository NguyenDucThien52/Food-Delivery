import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Model/Product.dart';
import 'package:food_delivery/Service/OrderItemAPI.dart';
import 'package:food_delivery/Service/ProductAPI.dart';

import '../../Model/Order.dart';
import '../../Model/OrderItem.dart';

class OrderHistory extends StatefulWidget {
  final List<Order> orders;

  const OrderHistory({required this.orders});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  // late Future<Product> product;
  late List<OrderItem> orderitems;
  List<int> totals = [];
  List<double> prices = [];

  @override
  void initState(){
    super.initState();
    for(int i=0; i<widget.orders.length; i++){
      int total = 0;
      double price = 0;
      OrderItemService().fetchOrderItems(widget.orders[i].order_id).then((value) {
        for(int j=0; j<value.length; j++){
          total += value[j].quantity;
          ProductService().getProductById(value[j].product_id).then((productData) {
            price += value[j].quantity + productData.price;
            print("quantity: ${value[j].quantity} and price: ${productData.price}");
          });
        }
        prices.add(price);
        totals.add(total);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.orders.length);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text("Lịch sử"),
      ),
      body: Column(
        children: [
          for (int i = 0; i < widget.orders.length; i++)
            GestureDetector(
              onTap: () {},
              child: SizedBox(
                width: 390,
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("order-id: ${widget.orders[i].order_id}"),
                        Text("số lượng sản phẩm: ${totals[i]}"),
                        Text("Tổng giá hóa đơn: ${prices[i]}"),
                      ],
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
