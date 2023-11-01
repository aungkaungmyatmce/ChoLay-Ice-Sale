import 'package:cloud_firestore/cloud_firestore.dart';

import 'transactions/product_transaction.dart';

class Order {
  final String customerName;
  final List<ProductTransaction> products;
  final DateTime orderTime;

  Order(
      {required this.customerName,
      required this.products,
      required this.orderTime});

  factory Order.fromJson(QueryDocumentSnapshot json) {
    Map<String, dynamic> jsonData = json.data() as Map<String, dynamic>;
    return Order(
      customerName: jsonData['customerName'],
      products: jsonData['products']
          .map((product) => ProductTransaction.fromJson(product)),
      orderTime: jsonData['orderTime'],
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
