import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Service/OrderAPI.dart';
import 'package:food_delivery/Service/OrderItemAPI.dart';
import 'package:food_delivery/View/Page/OrderItem_page.dart';

import '../../Model/Order.dart';
import '../../Model/OrderItem.dart';

class OrderHistory extends StatefulWidget {
  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  late Future<List<Order>> orders;
  late List<Future<List<OrderItem>>> orderitems;

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
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderItem_page(
                                    order: orderSnapshot.data![index],
                                  )));
                    },
                    child: SizedBox(
                      width: 390,
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tổng giá hóa đơn: ${orderSnapshot.data![index].totalAmount.toStringAsFixed(0)} đ",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text("Số lượng sản phẩm: ${orderSnapshot.data![index].quantity.toStringAsFixed(0)}"),
                              Text(
                                  "Date: ${orderSnapshot.data![index].orderDate.hour}:${orderSnapshot.data![index].orderDate.minute} - ${orderSnapshot.data![index].orderDate.day}/${orderSnapshot.data![index].orderDate.month}/${orderSnapshot.data![index].orderDate.year}"),
                              Text(
                                "Phương thức thanh toán: ${orderSnapshot.data![index].paymentMethod}",
                                style: TextStyle(fontSize: 12),
                              ),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(text: "Trạng thái: ", style: TextStyle(color: Colors.black87)),
                                  orderSnapshot.data![index].order_Status == "Đang giao hàng"
                                      ? TextSpan(text:
                                    "● Đang giao hàng",
                                    style: TextStyle(color: Colors.orange),
                                  )
                                      : TextSpan(text:
                                    "● Đã nhận hàng",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ]),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
