import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/Model/CartItem.dart';
import 'package:food_delivery/Service/CartItemAPI.dart';

import '../../Model/Cart.dart';
import '../../Model/Product.dart';

class ProductDetail_page extends StatefulWidget {
  final Product product;
  final Cart? cart;

  const ProductDetail_page({super.key, required this.product, required this.cart});

  @override
  State<ProductDetail_page> createState() => _ProductDetail_pageState();
}

class _ProductDetail_pageState extends State<ProductDetail_page> {
  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết sản phẩm"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.product.imageURL,
            fit: BoxFit.cover,
          ),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          widget.product.name,
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "${widget.product.price} đ",
                          style: TextStyle(fontSize: 20),
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text(
                          "Mô tả",
                          style: TextStyle(fontSize: 20),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite_border),
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: Text(widget.product.description)),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer, side: BorderSide()),
        onPressed: () {
          int cartItemid = DateTime.now().millisecondsSinceEpoch;
          CartItemService().fetchCartItem(widget.product.product_id, widget.cart!.cart_id).then((value) {
            if (value.quantity == 0) {
              CartItemService().saveCartItem(CartItem(
                  cart_id: widget.cart!.cart_id,
                  quantity: 1,
                  product_id: widget.product.product_id,
                  cartItem_id: cartItemid));
            } else {
              CartItemService().saveCartItem(CartItem(
                  cart_id: widget.cart!.cart_id,
                  quantity: (value.quantity + 1),
                  product_id: widget.product.product_id,
                  cartItem_id: value.cartItem_id));
            }
          });
        },
        child: Text("Đặt hàng"),
      ),
    );
  }
}
