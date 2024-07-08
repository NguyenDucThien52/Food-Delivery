import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Model/FavoriteShop.dart';
import 'package:food_delivery/Model/Shop.dart';
import 'package:food_delivery/Service/FavoriteShopAPI.dart';
import 'package:food_delivery/Service/ShopAPI.dart';

class Shop_page extends StatefulWidget {
  @override
  State<Shop_page> createState() => _Shop_pageState();
}

class _Shop_pageState extends State<Shop_page> {
  late Future<List<Shop>> shops;
  late Future<FavoriteShop> favoriteShop;

  @override
  void initState() {
    super.initState();
    shops = ShopService().fetchShop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Tìm kiếm",
                prefixIcon: Icon(Icons.search_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
              onChanged: (value) {
                print(value);
                setState(() {
                  shops = ShopService().getShopByKeyword(value);
                });
              },
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
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text("No shop is found"),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      favoriteShop = FavoriteShopService().getFavoriteShop(snapshot.data![index].shop_id);
                      return FutureBuilder(
                        future: favoriteShop,
                        builder: (context, fsSnapshot) {
                          if (fsSnapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (fsSnapshot.hasError) {
                            return Center(child: Text('Error: ${fsSnapshot.error}'));
                          } else {
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
                                  Column(
                                    children: [
                                      Text(snapshot.data![index].name, style: TextStyle(fontSize: 18),),
                                      Text(snapshot.data![index].address, style: TextStyle(color: Colors.black54),),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 120),
                                    child: IconButton(
                                      onPressed: () async {
                                        if (fsSnapshot.data!.email == "") {
                                          FavoriteShopService().saveFavoriteShop(FavoriteShop(
                                              favoriteShop_id: DateTime.now().millisecondsSinceEpoch,
                                              shop_id: snapshot.data![index].shop_id,
                                              email: FirebaseAuth.instance.currentUser!.email));
                                          await Future.delayed(Duration(seconds: 1));
                                          setState(() {});
                                        } else {
                                          FavoriteShopService().deleteFavoriteShop(fsSnapshot.data!.favoriteShop_id);
                                          await Future.delayed(Duration(seconds: 1));
                                          setState(() {});
                                        }
                                      },
                                      icon: fsSnapshot.data!.email == "" ? Icon(Icons.favorite_border) : Icon(Icons.favorite),
                                    ),
                                  )
                                ],
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
          ),
        ],
      ),
    );
  }
}
