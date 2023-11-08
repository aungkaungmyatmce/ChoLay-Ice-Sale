import '../models/targets/customer_target.dart';
import '../models/targets/transport_target.dart';
import '../models/targets/sale_target.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TargetRemoteDataSource {
  Future<List<SaleTarget>> getSaleTargetList({required DateTime tranMonth});
  Future<void> updateSaleTargetList(
      {required DateTime tranMonth, required List<SaleTarget> targetList});

  Future<List<TransportTarget>> getTransportTargetList(
      {required DateTime tranMonth});
  Future<void> updateTransportTargetList(
      {required DateTime tranMonth, required List<TransportTarget> targetList});

  Future<List<CustomerTarget>> getCustomerTargetList(
      {required DateTime tranMonth});
  Future<void> updateCustomerTargetList(
      {required DateTime tranMonth, required List<CustomerTarget> targetList});
}

class TargetRemoteDataSourceImpl extends TargetRemoteDataSource {
  CollectionReference targetCollection =
      FirebaseFirestore.instance.collection('targetList');
  @override
  Future<List<SaleTarget>> getSaleTargetList(
      {required DateTime tranMonth}) async {
    List<SaleTarget> targetList = [];
    DocumentSnapshot docSnapshot =
        await targetCollection.doc('targetList').get();
    if (!docSnapshot.exists) {
      throw Exception();
    }
    Map orderMap = docSnapshot.data() as Map;
    targetList = orderMap['targetList'];
    return targetList;
  }

  @override
  Future<void> updateSaleTargetList(
      {required DateTime tranMonth, required List<SaleTarget> targetList}) {
    // TODO: implement updateSaleTargetList
    throw UnimplementedError();
  }

  @override
  Future<List<TransportTarget>> getTransportTargetList(
      {required DateTime tranMonth}) {
    // TODO: implement getTransportTargetList
    throw UnimplementedError();
  }

  @override
  Future<void> updateTransportTargetList(
      {required DateTime tranMonth,
      required List<TransportTarget> targetList}) {
    // TODO: implement updateTransportTargetList
    throw UnimplementedError();
  }

  @override
  Future<List<CustomerTarget>> getCustomerTargetList(
      {required DateTime tranMonth}) {
    // TODO: implement getCustomerTargetList
    throw UnimplementedError();
  }

  @override
  Future<void> updateCustomerTargetList(
      {required DateTime tranMonth, required List<CustomerTarget> targetList}) {
    // TODO: implement updateCustomerTargetList
    throw UnimplementedError();
  }
}
