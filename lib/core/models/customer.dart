import 'package:cloud_firestore/cloud_firestore.dart';

class Customer {
  final String name;
  final String phNo;
  final GeoPoint location;
  final String? buyingProduct;

  Customer(
      {required this.name,
      required this.phNo,
      required this.location,
      this.buyingProduct});

  factory Customer.fromJson(QueryDocumentSnapshot json) {
    Map<String, dynamic> jsonData = json.data() as Map<String, dynamic>;
    return Customer(
      name: jsonData['name'],
      phNo: jsonData['phNo'],
      location: jsonData['location'],
      buyingProduct: jsonData['buyingProduct'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['phNo'] = phNo;
    map['location'] = location;
    map['buyingProduct'] = buyingProduct;
    return map;
  }
}
