import 'package:cholay_ice_sale/core/models/transactions/product_transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SaleTransaction {
  final String? tranId;
  final String customerName;
  final DateTime tranDate;
  final String productName;
  final int quantity;
  final int price;
  final int totalPrice;

  SaleTransaction(
      {this.tranId,
      required this.customerName,
      required this.tranDate,
      required this.productName,
      required this.quantity,
      required this.price,
      required this.totalPrice});

  factory SaleTransaction.fromJson(QueryDocumentSnapshot json) {
    Map<String, dynamic> jsonData = json.data() as Map<String, dynamic>;

    return SaleTransaction(
      tranId: json.id,
      customerName: jsonData['customerName'],
      tranDate: DateTime.parse(jsonData['tranDate'].toDate().toString()),
      productName: jsonData['productName'],
      quantity: jsonData['quantity'],
      price: jsonData['price'],
      totalPrice: jsonData['totalPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['customerName'] = customerName;
    map['tranDate'] = tranDate;
    map['productName'] = productName;
    map['productName'] = productName;
    map['quantity'] = quantity;
    map['price'] = price;
    map['totalPrice'] = totalPrice;
    return map;
  }
}
