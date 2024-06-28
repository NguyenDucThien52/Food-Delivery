import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Model/Shop.dart';
import 'package:food_delivery/Service/ShopAPI.dart';


class Shop_page extends StatefulWidget {
  @override
  State<Shop_page> createState() => _Shop_pageState();
}

class _Shop_pageState extends State<Shop_page> {
  late Future<List<Shop>> shops;

  @override
  void initState() {
    super.initState();
    shops = ShopService().fetchShop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Center(child: Text("Cửa hàng")),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            child: FutureBuilder <List<Shop>>(
              future: shops,
              builder: (context, snapshot){
                return Card(
                  child: Row(
                    children: [
                      // Image.network(snapshot.data![index].imageURL),
                    ],
                  ),
                );
              },
            )
          ),
        ],
      ),
    );
  }
}
