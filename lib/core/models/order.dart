import 'package:cloud_firestore/cloud_firestore.dart';

import 'transactions/product_transaction.dart';

class Order {
  final String? orderId;
  final String customerName;
  final List<ProductInfo> products;
  final DateTime orderTime;

  Order(
      {this.orderId,
      required this.customerName,
      required this.products,
      required this.orderTime});

  factory Order.fromJson(QueryDocumentSnapshot json) {
    Map<String, dynamic> jsonData = json.data() as Map<String, dynamic>;
    return Order(
      orderId: json.id,
      customerName: jsonData['customerName'],
      products: jsonData['products']
          .map((product) => ProductInfo.fromJson(product))
          .toList()
          .cast<ProductInfo>(),
      orderTime: DateTime.parse(jsonData['orderTime'].toDate().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['customerName'] = customerName;
    map['products'] = products.map((product) => product.toJson()).toList();
    map['orderTime'] = orderTime;
    return map;
  }
}
