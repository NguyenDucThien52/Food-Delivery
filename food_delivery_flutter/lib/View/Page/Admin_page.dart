import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Service/OrderAPI.dart';
import 'package:food_delivery/View/Page/OrderItem_page.dart';

import '../../Model/Order.dart';

class Admin_page extends StatefulWidget {
  @override
  State<Admin_page> createState() => _Admin_pageState();
}

class _Admin_pageState extends State<Admin_page> {
  late Future<List<Order>> orders;

  @override
  void initState() {
    super.initState();
    orders = OrderService().getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý đơn hàng"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: orders,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return Center(
                  child: Text("Không tìm thấy đơn hàng"),
                );
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Order order = snapshot.data![index];
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OrderItem_page(order: order)));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tổng giá hóa đơn: ${snapshot.data![index].totalAmount.toStringAsFixed(0)} đ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text("Email: ${snapshot.data![index].email}"),
                                  Text("Số lượng sản phẩm: ${snapshot.data![index].quantity.toStringAsFixed(0)}"),
                                  Text(
                                      "Date: ${snapshot.data![index].orderDate.hour}:${snapshot.data![index].orderDate.minute} - ${snapshot.data![index].orderDate.day}/${snapshot.data![index].orderDate.month}/${snapshot.data![index].orderDate.year}"),
                                  Text(
                                    "Phương thức thanh toán: ${snapshot.data![index].paymentMethod}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  RichText(
                                    text: TextSpan(children: [
                                      TextSpan(text: "Trạng thái: ", style: TextStyle(color: Colors.black87)),
                                      snapshot.data![index].order_Status == "Đang giao hàng"
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
                      );
                    });
              }
            },
          )
        ],
      ),
    );
  }
}
