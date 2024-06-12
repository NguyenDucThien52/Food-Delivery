// import 'dart:ffi';

// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class Shop1 {
  int id;
  String name;
  String address;
  String phoneNumber;

  Shop1({required this.id, required this.name, required this.address, required this.phoneNumber});
}

class Shop extends StatelessWidget {
  List<Shop1> shops = [
    Shop1(id: 1, name: 'Shop A', address: '123 Main St', phoneNumber: '123-456-7890'),
    Shop1(id: 2, name: 'Shop B', address: '456 Elm St', phoneNumber: '098-765-4321'),
    Shop1(id: 3, name: 'Shop C', address: '789 Oak St', phoneNumber: '555-555-5555'),
    Shop1(id: 4, name: 'Shop D', address: '101 Maple St', phoneNumber: '111-222-3333'),
    Shop1(id: 5, name: 'Shop E', address: '202 Pine St', phoneNumber: '444-666-7777'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Cửa hàng"),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Tìm kiếm",
                  prefixIcon: Icon(Icons.search_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Chuỗi danh sách các cửa hàng"),
            Expanded(
              child: ListView.builder(
                itemCount: shops.length,
                itemBuilder: (context, index) {
                  final shop = shops[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Card(
                      child: ListTile(
                        leading: Image.network(
                          "https://loremflickr.com/320/240/restaurant?random=1",
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(shop.name),
                            Text(
                              shop.address,
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
