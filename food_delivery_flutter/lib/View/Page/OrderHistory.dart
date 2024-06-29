import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Model/Product.dart';
import 'package:food_delivery/Service/OrderAPI.dart';
import 'package:food_delivery/Service/OrderItemAPI.dart';
import 'package:food_delivery/Service/ProductAPI.dart';

import '../../Model/Order.dart';
import '../../Model/OrderItem.dart';

class OrderHistory extends StatefulWidget {
  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  late Future<List<Order>> orders;
  late List<OrderItem> orderitems;

  @override
  void initState() {
    super.initState();
    orders = OrderService().fetchOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text("Lịch sử"),
      ),
      body: FutureBuilder<List<Order>>(
        future: orders,
        builder: (context, orderSnapshot) {
          if (orderSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (orderSnapshot.hasError) {
            return Center(child: Text('Error: ${orderSnapshot.error}'));
          } else if (!orderSnapshot.hasData || orderSnapshot.data!.isEmpty) {
            return Center(child: Text('No orders found.'));
          } else {
            return ListView.builder(
              itemCount: orderSnapshot.data!.length,
              itemBuilder: (context, index) {
                return FutureBuilder<List<OrderItem>>(
                  future: OrderItemService().fetchOrderItems(orderSnapshot.data![index].order_id),
                  builder: (context, snapshot) {
                    print(snapshot.data!.length);
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No order items found.'));
                    } else {
                      List<int> totalProducts = snapshot.data!.map((item) => item.quantity).toList();
                      int totalQuantity = totalProducts.fold(0, (sum, item) => sum + item);
                      return GestureDetector(
                        onTap: () {},
                        child: SizedBox(
                          width: 390,
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Order ID: ${orderSnapshot.data![index].order_id}"),
                                  Text("Số lượng sản phẩm: $totalQuantity"),
                                  Text("Tổng giá hóa đơn: ${orderSnapshot.data![index].totalAmount}"),
                                  Text("Phương thức thanh toán: ${orderSnapshot.data![index].paymentMethod}"),
                                  Text("Date: ${orderSnapshot.data![index].orderDate}"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
