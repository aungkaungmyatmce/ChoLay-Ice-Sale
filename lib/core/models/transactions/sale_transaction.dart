import 'package:cholay_ice_sale/core/models/transactions/product_transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SaleTransaction {
  final String tranId;
  final String customerName;
  final DateTime tranDate;
  final List<ProductTransaction> products;
  final int totalPrice;

  SaleTransaction(
      {required this.tranId,
      required this.customerName,
      required this.tranDate,
      required this.products,
      required this.totalPrice});

  factory SaleTransaction.fromJson(QueryDocumentSnapshot json) {
    Map<String, dynamic> jsonData = json.data() as Map<String, dynamic>;
    return SaleTransaction(
      tranId: json.id,
      customerName: jsonData['customerName'],
      tranDate: jsonData['tranDate'],
      products: jsonData['products']
          .map((product) => ProductTransaction.fromJson(product)),
      totalPrice: jsonData['totalPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['customerName'] = customerName;
    map['tranDate'] = tranDate;
    map['products'] = products.map((product) => product.toJson()).toList();
    map['totalPrice'] = totalPrice;
    return map;
  }
}
