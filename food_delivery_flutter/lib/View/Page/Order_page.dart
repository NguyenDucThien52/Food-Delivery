import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Order_page extends StatefulWidget {
  final double total;

  const Order_page({super.key, required this.total});

  @override
  State<Order_page> createState() => _Order_pageState();
}

class _Order_pageState extends State<Order_page> {
  int _selectedValue = 1;
  TextEditingController _addressController = TextEditingController();

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
              SizedBox(height: 50,),
              ElevatedButton(
                onPressed: () {

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
