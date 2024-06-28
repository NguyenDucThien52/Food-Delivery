import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../Model/Order.dart';

class OrderHistory extends StatefulWidget {
  final List<Order> orders;

  const OrderHistory({required this.orders});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
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
              child: Card(
                  child: Row(
                children: [
                  Text("order-id: "),
                  Text("số lượng sản phẩm: "),
                  Text("Tổng hóa đơn: "),
                ],
              )),
            )
        ],
      ),
    );
  }
}
