import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
            child: FutureBuilder<List<Shop>>(
              future: shops,
              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  child: Image.network(
                                    snapshot.data![index].imageURL,
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ))),
                          Text(snapshot.data![index].name),
                          Padding(
                            padding: EdgeInsets.only(left: 140),
                            child: IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
