import 'package:cholay_ice_sale/core/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;

abstract class OrderRemoteDataSource {
  Future<List<Order>> getOrderList();
  Future<void> addOrder({required Order order});
  Future<void> deleteOrder({required Order order});
}

class OrderRemoteDataSourceImpl extends OrderRemoteDataSource {
  CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('orderList');

  @override
  Future<List<Order>> getOrderList() async {
    List<Order> orderList = [];
    QuerySnapshot snapshot = await orderCollection.get();

    List docList = snapshot.docs;

    if (docList.isEmpty) {
      throw Exception();
    }
    docList.map((doc) {
      orderList.add(Order.fromJson(doc));
    }).toList();
    return orderList;
  }

  @override
  Future<void> addOrder({required Order order}) async {
    await orderCollection.add(order.toJson());
  }

  @override
  Future<void> deleteOrder({required Order order}) async {
    await orderCollection.doc(order.orderId).delete();
  }
}
