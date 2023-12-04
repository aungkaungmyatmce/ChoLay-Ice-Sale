import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/targets/customer_target.dart';
import '../models/targets/transport_target.dart';
import '../models/targets/sale_target.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TargetRemoteDataSource {
  Future<List<SaleTarget>> getSaleTargetList({required DateTime targetMonth});
  Future<void> updateSaleTargetList({required List<SaleTarget> targetList});

  Future<List<TransportTarget>> getTransportTargetList(
      {required DateTime targetMonth});
  Future<void> updateTransportTargetList(
      {required List<TransportTarget> targetList});

  Future<List<CustomerTarget>> getCustomerTargetList(
      {required DateTime targetMonth});
  Future<void> updateCustomerTargetList(
      {required DateTime targetMonth,
      required List<CustomerTarget> targetList});
}

class TargetRemoteDataSourceImpl extends TargetRemoteDataSource {
  CollectionReference targetCollection =
      FirebaseFirestore.instance.collection('allTargets');
  @override
  Future<List<SaleTarget>> getSaleTargetList(
      {required DateTime targetMonth}) async {
    List<SaleTarget> targetList = [];
    DocumentSnapshot docSnapshot = await targetCollection
        .doc('saleTarget')
        .collection('targets')
        .doc(DateFormat.yMMM().format(targetMonth).toString())
        .get();
    if (!docSnapshot.exists) {
      throw Exception();
    }
    Map<String, dynamic> jsonData = docSnapshot.data() as Map<String, dynamic>;
    targetList = jsonData['targets']
        .map((saleTarget) => SaleTarget.fromJson(saleTarget))
        .toList()
        .cast<SaleTarget>();
    return targetList;
  }

  @override
  Future<void> updateSaleTargetList(
      {required List<SaleTarget> targetList}) async {
    var response;
    DocumentSnapshot docSnapshot = await targetCollection
        .doc('saleTarget')
        .collection('targets')
        .doc(DateFormat.yMMM().format(DateTime.now()).toString())
        .get();
    if (docSnapshot.exists) {
      await targetCollection
          .doc('saleTarget')
          .collection('targets')
          .doc(DateFormat.yMMM().format(DateTime.now()).toString())
          .update({
        'targets': targetList.map((target) => target.toJson()).toList(),
      });
    } else {
      await targetCollection
          .doc('saleTarget')
          .collection('targets')
          .doc(DateFormat.yMMM().format(DateTime.now()).toString())
          .set({
        'targets': targetList.map((target) => target.toJson()).toList(),
      });
    }
    return response;
  }

  @override
  Future<List<TransportTarget>> getTransportTargetList(
      {required DateTime targetMonth}) async {
    List<TransportTarget> targetList = [];
    DocumentSnapshot docSnapshot = await targetCollection
        .doc('transportTarget')
        .collection('targets')
        .doc(DateFormat.yMMM().format(targetMonth).toString())
        .get();
    if (docSnapshot.data() == null) {
      throw Exception();
    }
    Map<String, dynamic> jsonData = docSnapshot.data() as Map<String, dynamic>;
    targetList = jsonData['targets']
        .map((target) => TransportTarget.fromJson(target))
        .toList()
        .cast<TransportTarget>();
    return targetList;
  }

  @override
  Future<void> updateTransportTargetList(
      {required List<TransportTarget> targetList}) async {
    var response;

    DocumentSnapshot docSnapshot = await targetCollection
        .doc('transportTarget')
        .collection('targets')
        .doc(DateFormat.yMMM().format(DateTime.now()).toString())
        .get();
    if (docSnapshot.exists) {
      await targetCollection
          .doc('transportTarget')
          .collection('targets')
          .doc(DateFormat.yMMM().format(DateTime.now()).toString())
          .update({
        'targets': targetList.map((target) => target.toJson()).toList(),
      });
    } else {
      await targetCollection
          .doc('transportTarget')
          .collection('targets')
          .doc(DateFormat.yMMM().format(DateTime.now()).toString())
          .set({
        'targets': targetList.map((target) => target.toJson()).toList(),
      });
    }
    return response;
  }

  @override
  Future<List<CustomerTarget>> getCustomerTargetList(
      {required DateTime targetMonth}) {
    // TODO: implement getCustomerTargetList
    throw UnimplementedError();
  }

  @override
  Future<void> updateCustomerTargetList(
      {required DateTime targetMonth,
      required List<CustomerTarget> targetList}) {
    // TODO: implement updateCustomerTargetList
    throw UnimplementedError();
  }
}
