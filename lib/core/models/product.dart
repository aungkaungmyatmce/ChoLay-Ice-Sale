import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String name;
  final int price;

  Product({required this.name, required this.price});

  factory Product.fromJson(QueryDocumentSnapshot json) {
    Map<String, dynamic> jsonData = json.data() as Map<String, dynamic>;
    return Product(
      name: jsonData['name'],
      price: jsonData['price'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['price'] = price;
    return map;
  }
}
