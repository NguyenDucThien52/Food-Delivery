import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Service/CartAPI.dart';
import 'package:food_delivery/Service/ProductAPI.dart';
import 'package:food_delivery/View/Page/ProductDetail_page.dart';

import '../../Model/Cart.dart';
import '../../Model/CartItem.dart';
import '../../Model/Product.dart';
import '../../Service/CartItemAPI.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Future<List<Product>> products = Future.value([]);
  late Future<Cart> cart;

  @override
  void initState(){
    super.initState();
    cart = CartService().fetchCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tìm kiếm"),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
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
                setState(() {
                  products = ProductService().getProductbyKeyWord(value);
                });
              },
            ),
          ),
          FutureBuilder(
            future: products,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No products is found'));
              } else {
                return SizedBox(
                  height: 400,
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder(future: cart,builder: (context, cartSnapshot) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail_page(product: snapshot.data![index], cart: cartSnapshot.data)));
                          },
                          child: Card(
                            child: ListTile(
                              leading: Image.network(
                                snapshot.data![index].imageURL,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data![index].name),
                                  Text(snapshot.data![index].price.toStringAsFixed(0)),
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  int cartItemid = DateTime.now().millisecondsSinceEpoch;
                                  CartItemService()
                                      .fetchCartItem(
                                      snapshot.data![index].product_id, cartSnapshot.data!.cart_id)
                                      .then((value) {
                                    print(value.quantity);
                                    if (value.quantity == 0) {
                                      CartItemService().saveCartItem(CartItem(
                                          cart_id: cartSnapshot.data!.cart_id,
                                          quantity: 1,
                                          product_id: snapshot.data![index].product_id,
                                          cartItem_id: cartItemid));
                                    } else {
                                      CartItemService().saveCartItem(CartItem(
                                          cart_id: cartSnapshot.data!.cart_id,
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
                      });
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
