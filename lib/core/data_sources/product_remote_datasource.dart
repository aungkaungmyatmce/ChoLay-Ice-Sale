import 'package:cholay_ice_sale/core/models/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> getProductList();
  Future<void> updateProductList({required List<Product> productList});
}

class ProductRemoteDataSourceImpl extends ProductRemoteDataSource {
  CollectionReference productCollection =
      FirebaseFirestore.instance.collection('productList');

  @override
  Future<List<Product>> getProductList() async {
    List<Product> productList = [];
    DocumentSnapshot docSnapshot =
        await productCollection.doc('productList').get();
    if (!docSnapshot.exists) {
      throw Exception();
    }
    Map<String, dynamic> proMap = docSnapshot.data() as Map<String, dynamic>;
    productList = proMap['productList']
        .map((pro) => Product.fromJson(pro))
        .toList()
        .cast<Product>();
    return productList;
  }

  @override
  Future<void> updateProductList({required List<Product> productList}) async {
    await productCollection.doc('productList').update({
      'productList': productList.map((product) => product.toJson()).toList(),
    });
  }
}
