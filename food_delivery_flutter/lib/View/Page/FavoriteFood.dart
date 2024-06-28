import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteFood extends StatefulWidget {
  @override
  State<FavoriteFood> createState() => _FavoriteFoodState();
}

class _FavoriteFoodState extends State<FavoriteFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text("Yêu thích"),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
