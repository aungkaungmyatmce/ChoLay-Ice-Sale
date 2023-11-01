import 'package:cholay_ice_sale/core/models/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CustomerRemoteDataSource {
  Future<List<Customer>> getCustomerList();
  Future<void> updateCustomerList({required List<Customer> customerList});
}

class CustomerRemoteDataSourceImpl extends CustomerRemoteDataSource {
  CollectionReference customerCollection =
      FirebaseFirestore.instance.collection('customerList');

  @override
  Future<List<Customer>> getCustomerList() async {
    List<Customer> customerList = [];
    DocumentSnapshot docSnapshot =
        await customerCollection.doc('customerList').get();
    if (docSnapshot.exists) {
      throw Exception();
    }
    Map cusMap = docSnapshot.data() as Map;
    customerList = cusMap['customerList'];
    return customerList;
  }

  @override
  Future<void> updateCustomerList(
      {required List<Customer> customerList}) async {
    final response = await customerCollection.doc('customerList').update({
      'customerList':
          customerList.map((customer) => customer.toJson()).toList(),
    });
    return response;
  }
}
