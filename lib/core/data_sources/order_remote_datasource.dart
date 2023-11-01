import 'package:cholay_ice_sale/core/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;

abstract class OrderRemoteDataSource {
  Future<List<Order>> getOrderList();
  Future<void> updateOrderList({required List<Order> orderList});
}

class OrderRemoteDataSourceImpl extends OrderRemoteDataSource {
  CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('orderList');

  @override
  Future<List<Order>> getOrderList() async {
    List<Order> orderList = [];
    DocumentSnapshot docSnapshot = await orderCollection.doc('orderList').get();
    if (docSnapshot.exists) {
      throw Exception();
    }
    Map orderMap = docSnapshot.data() as Map;
    orderList = orderMap['orderList'];
    return orderList;
  }

  @override
  Future<void> updateOrderList({required List<Order> orderList}) async {
    await orderCollection.doc('orderList').update({
      'orderList': orderList.map((customer) => customer.toJson()).toList(),
    });
  }
}
