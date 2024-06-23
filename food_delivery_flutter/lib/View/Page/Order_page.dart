import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Model/Receiver.dart';
import 'package:food_delivery/Service/OrderAPI.dart';
import 'package:food_delivery/Service/ReceiverAPI.dart';

import '../../Model/Order.dart';
import '../../Model/User.dart';

class Order_page extends StatefulWidget {
  final double total;
  final Person user;

  const Order_page({super.key, required this.total, required this.user});

  @override
  State<Order_page> createState() => _Order_pageState();
}

class _Order_pageState extends State<Order_page> {
  int _selectedValue = 1;
  TextEditingController _addressController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Thông tin người nhận",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            height: 200,
            width: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text("Tên người nhận"),
                TextFormField(controller: _nameController),
                Text("Số điện thoại"),
                TextField(controller: _phoneNumberController)
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cập nhật'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.fullName;
    _phoneNumberController.text = widget.user.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    final double tax = widget.total * 0.03;
    final double ship = widget.total * 0.15;
    final double Total = widget.total + tax + ship;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Thông tin hóa đơn",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    TextOrder(name: "Order", price: widget.total),
                    TextOrder(name: "Thuế", price: tax),
                    TextOrder(name: "Phí ship", price: ship),
                    Divider(height: 20, thickness: 1, indent: 10, endIndent: 10, color: Colors.grey),
                    SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tổng", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("$Total đ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Dự khiến giao hàng", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text("30-60 phút", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Phương thức thanh toán",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: SizedBox(
                  height: 50,
                  width: 370,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedValue = 1;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(_selectedValue == 1 ? Icons.circle : Icons.circle_outlined),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Thanh toán khi nhận hàng",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: SizedBox(
                  height: 50,
                  width: 370,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        )),
                    onPressed: () {
                      setState(() {
                        _selectedValue = 2;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(_selectedValue == 2 ? Icons.circle_rounded : Icons.circle_outlined),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Thanh toán bằng tài khoản ngân hàng",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              SizedBox(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          print(_nameController);
                          _showPopup(context);
                        },
                        child: Container(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Địa chỉ giao hàng",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                controller: _addressController,
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  int id = DateTime.now().millisecondsSinceEpoch;
                  ReceiverSerice().insertReceiver(Receiver(
                      receiver_id: id,
                      receiver_name: _nameController.text,
                      receiver_phone: _phoneNumberController.text));
                  DateTime dateTime = DateTime.now();
                  OrderService().insertOrder(Order(
                      email: widget.user.email,
                      deliveryAddress: _addressController.text,
                      order_id: id,
                      orderDate: dateTime,
                      totalAmount: Total,
                      paymentMethod:
                          _selectedValue == 1 ? "Thanh toán khi nhận hàng" : "Thanh toán bằng tài khoản ngân hàng",
                      receiver_id: id));
                },
                child: Text("Thanh Toán"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextOrder extends StatelessWidget {
  final String name;
  final double price;

  const TextOrder({required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: TextStyle(fontSize: 16, color: Colors.grey)),
          Text("$price đ", style: TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }
}
