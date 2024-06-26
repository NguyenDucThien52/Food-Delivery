import 'dart:ffi';

class Product{
  final int product_id;
  final String name;
  final String description;
  final double price;
  final int category_id;
  final String imageURL;

  Product({required this.product_id, this.name='', this.description='', this.price=0, required this.category_id, this.imageURL=''});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      product_id: json['product_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      category_id: json['category_id'],
      imageURL: json['imageURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': product_id,
      'name': name,
      'description': description,
      'price': price,
      'category_id': category_id,
      'imageURL': imageURL,
    };
  }

  factory Product.toJson(Map<String, dynamic> json) {
    return Product(
      product_id: json['product_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      category_id: json['category_id'],
      imageURL: json['imageURL'],
    );
  }
}