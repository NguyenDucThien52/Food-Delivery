import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/Model/FavoriteFood.dart';
import 'package:food_delivery/Service/ProductAPI.dart';

import '../../Model/Cart.dart';
import '../../Model/CartItem.dart';
import '../../Model/Product.dart';
import '../../Service/CartItemAPI.dart';
import '../../Service/FavoriteFoodAPI.dart';

class FavoriteFood_page extends StatefulWidget {
  final Cart cart;

  FavoriteFood_page({required this.cart});

  @override
  State<FavoriteFood_page> createState() => _FavoriteFood_pageState();
}

class _FavoriteFood_pageState extends State<FavoriteFood_page> {
  late Future<List<FavoriteFood>> favoritefoods;
  List<int> products_id = [];
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    favoritefoods = FavoriteFoodService().fetchAllFavoriteFoods();
    favoritefoods.then((value) {
      for (int i = 0; i < value.length; i++) {
        products_id.add(value[i].product_id);
      }
      products = ProductService().getProductsByCartItem(products_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text("Yêu thích"),
      ),
      body: FutureBuilder<List<FavoriteFood>>(
        future: favoritefoods,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Không có món ăn yêu thích'));
          } else {
            return FutureBuilder<List<Product>>(
              future: products,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          size: 100,
                        ),
                        Text('không có món ăn yêu thích')
                      ],
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(5),
                        child: Card(
                          child: ListTile(
                            leading: Image.network(
                              snapshot.data![index].imageURL,
                              fit: BoxFit.cover,
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data![index].name),
                                Text(
                                  snapshot.data![index].price.toStringAsFixed(0),
                                )
                              ],
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                int cartItemid = DateTime.now().millisecondsSinceEpoch;
                                CartItemService()
                                    .fetchCartItem(snapshot.data![index].product_id, widget.cart.cart_id)
                                    .then((value) {
                                  print(value.quantity);
                                  if (value.quantity == 0) {
                                    CartItemService().saveCartItem(CartItem(
                                        cart_id: widget.cart.cart_id,
                                        quantity: 1,
                                        product_id: snapshot.data![index].product_id,
                                        cartItem_id: cartItemid));
                                  } else {
                                    CartItemService().saveCartItem(CartItem(
                                        cart_id: widget.cart.cart_id,
                                        quantity: (value.quantity + 1),
                                        product_id: snapshot.data![index].product_id,
                                        cartItem_id: value.cartItem_id));
                                  }
                                });
                              },
                              icon: Icon(Icons.add_circle_outline),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
