class Shop{
  final int shop_id;
  final String name;
  final String address;
  final String imageURL;

  Shop({required this.shop_id, required this.name, required this.address, required  this.imageURL});

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
        shop_id: json['shop_id'],
        name: json['name'],
        address: json['address'],
        imageURL: json['imageURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shop_id': shop_id,
      'name': name,
      'address': address,
      'imageURL': imageURL,
    };
  }

  factory Shop.toJson(Map<String, dynamic> json) {
    return Shop(
        shop_id: json['shop_id'],
        name: json['name'],
        address: json['address'],
        imageURL: json['imageURL'],
    );
  }
}