class Product{
  final int? product_id;
  final String name;
  final String description;
  final double price;
  final String? imageURL;

  Product({this.product_id, this.name='', this.description='', this.price=0, this.imageURL=''});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      product_id: json['product_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageURL: json['imageURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': product_id,
      'name': name,
      'description': description,
      'price': price,
      'imageURL': imageURL,
    };
  }

  factory Product.toJson(Map<String, dynamic> json) {
    return Product(
      product_id: json['product_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      imageURL: json['imageURL'],
    );
  }
}