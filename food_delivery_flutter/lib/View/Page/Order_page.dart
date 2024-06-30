import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Model/CartItem.dart';
import 'package:food_delivery/Model/OrderItem.dart';
import 'package:food_delivery/Model/Product.dart';
import 'package:food_delivery/Model/Receiver.dart';
import 'package:food_delivery/Service/CartItemAPI.dart';
import 'package:food_delivery/Service/OrderAPI.dart';
import 'package:food_delivery/Service/OrderItemAPI.dart';
import 'package:food_delivery/Service/ReceiverAPI.dart';

import '../../Model/Order.dart';
import '../../Model/User.dart';

class Order_page extends StatefulWidget {
  final double total;
  final Person user;
  final List<CartItem> cartItemsList;
  final List<Product> productList;

  const Order_page(
      {super.key, required this.total, required this.user, required this.cartItemsList, required this.productList});

  @override
  State<Order_page> createState() => _Order_pageState();
}

class _Order_pageState extends State<Order_page> {
  int _selectedValue = 1;
  TextEditingController _addressController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  late Receiver receiver;

  void _showPopuNamePhonenumber(BuildContext context) {
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
                print(_phoneNumberController.text);
                _updateNameNPhoneNumber(_nameController.text, _phoneNumberController.text);
                Navigator.of(context).pop();
              },
              child: Text('Cập nhật'),
            ),
          ],
        );
      },
    );
  }

  void _showPopuAddress(BuildContext context) {
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
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _updateAddress(_addressController.text);
                Navigator.of(context).pop();
              },
              child: Text('Cập nhật'),
            ),
          ],
        );
      },
    );
  }

  void _updateNameNPhoneNumber(String name, String phoneNumber) {
    setState(() {
      receiver.receiver_name = name;
      receiver.receiver_phone = phoneNumber;
    });
  }

  void _updateAddress(String address) {
    setState(() {
      _addressController.text = address;
    });
  }

  @override
  void initState() {
    super.initState();
    receiver = Receiver(
        receiver_id: DateTime.now().millisecondsSinceEpoch,
        receiver_name: widget.user.fullName,
        receiver_phone: widget.user.phoneNumber);
    _nameController.text = receiver.receiver_name;
    _phoneNumberController.text = receiver.receiver_phone;
    _addressController.text = widget.user.address;
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
                padding: EdgeInsets.all(10),
                child: Text(
                  "Thông tin người nhận hàng",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 150,
                width: 390,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showPopuAddress(context);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Địa chỉ giao hàng",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                          Padding(
                              padding: EdgeInsets.all(15),
                              child: Text(
                                _addressController.text == ""
                                    ? "Vui lòng chọn địa chỉ nhận hàng"
                                    : _addressController.text,
                                style: TextStyle(color: Colors.grey),
                              )),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _showPopuNamePhonenumber(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Colors.black, width: 1.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(receiver.receiver_name),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(receiver.receiver_phone),
                                  ),
                                  // Divider(height: 2, thickness: 3)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text("Dự kiến giao hàng", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              SizedBox(height: 5),
                              Text("30-60 phút", style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Sản phẩm đã chọn",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                width: 350,
                child: Column(
                  children: [
                    for (int i = 0; i < widget.cartItemsList.length; i++)
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("x${widget.cartItemsList[i].quantity} ${widget.productList[i].name}"),
                            Text("${widget.productList[i].price*widget.cartItemsList[i].quantity} đ"),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Tổng cộng:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    TextOrder(name: "Order", price: widget.total),
                    TextOrder(name: "Thuế", price: tax),
                    TextOrder(name: "Phí ship", price: ship),
                    Divider(height: 20, thickness: 1, indent: 10, endIndent: 10, color: Colors.grey),
                    SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Tổng", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          Text("$Total đ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(10),
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
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  int id = DateTime.now().millisecondsSinceEpoch;
                  ReceiverSerice().insertReceiver(receiver);
                  DateTime dateTime = DateTime.now();
                  double quantity = 0;
                  for(int i=0; i<widget.cartItemsList.length; i++){
                    quantity += widget.cartItemsList[i].quantity;
                  }
                  OrderService().insertOrder(Order(
                      email: widget.user.email,
                      deliveryAddress: _addressController.text,
                      order_id: id,
                      orderDate: dateTime,
                      totalAmount: Total,
                      quantity: quantity,
                      paymentMethod:
                          _selectedValue == 1 ? "Thanh toán khi nhận hàng" : "Thanh toán bằng tài khoản ngân hàng",
                      receiver_id: id));
                  for (int i = 0; i < widget.productList.length; i++) {
                    int orderItemId = Random().nextInt(10000000);
                    OrderItemService().saveOrderItem(OrderItem(
                        orderItem_id: orderItemId,
                        quantity: widget.cartItemsList[i].quantity,
                        product_id: widget.cartItemsList[i].product_id,
                        order_id: id));
                    CartItemService().deleteCartItem(widget.cartItemsList[i].cartItem_id);
                  };
                  Navigator.pop(context);
                  Navigator.pop(context);
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
