import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Model/Category.dart';
import 'package:food_delivery/Service/ProductAPI.dart';

import '../../Model/Cart.dart';
import '../../Model/CartItem.dart';
import '../../Model/Product.dart';
import '../../Service/CartItemAPI.dart';

class Category_page extends StatefulWidget {
  final Category category;
  final Cart? cart;

  const Category_page({super.key, required this.category, required this.cart});

  @override
  State<Category_page> createState() => _Category_pageState();
}

class _Category_pageState extends State<Category_page> {
  late Future<List<Product>> products;

  void showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Bạn đã thêm thành công sản phẩm vào giỏ hàng!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    products = ProductService().getProductByCategory(widget.category.category_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
      ),
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text("No products found in cart"),
            );
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.60,
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Product product = snapshot.data![index];
                return Card(
                  elevation: 4.0,
                  child: SizedBox(
                    width: 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: Image.network(
                              product.imageURL,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 116,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      product.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      '\$${product.price.toStringAsFixed(2)}',
                                      style: TextStyle(fontSize: 16, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 70,
                              width: 50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      int cartItemid = DateTime.now().millisecondsSinceEpoch;
                                      CartItemService()
                                          .fetchCartItem(product.product_id, widget.cart!.cart_id)
                                          .then((value) {
                                        print(value.quantity);
                                        if (value.quantity == 0) {
                                          CartItemService().saveCartItem(CartItem(
                                            cart_id: widget.cart!.cart_id,
                                            quantity: 1,
                                            product_id: product.product_id,
                                            cartItem_id: cartItemid,
                                          ));
                                        } else {
                                          CartItemService().saveCartItem(CartItem(
                                            cart_id: widget.cart!.cart_id,
                                            quantity: (value.quantity + 1),
                                            product_id: product.product_id,
                                            cartItem_id: value.cartItem_id,
                                          ));
                                        }
                                      });
                                      showSnackBar(context);
                                    },
                                    icon: Icon(Icons.add_circle_outline, size: 35),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
