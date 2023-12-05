import 'package:cholay_ice_sale/core/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../core/models/app_error.dart';
import '../../../core/models/product.dart';
import '../../../core/models/targets/sale_target.dart';
import '../../../core/repositories/target_repository.dart';
import '../../../di/get_it.dart';

class ProductNamesViewModel with ChangeNotifier {
  ProductRepository productRepository = getItInstance<ProductRepository>();
  TargetRepository targetRepository = getItInstance<TargetRepository>();

  List<Product> productList = [];
  List<SaleTarget> saleTargetList = [];
  AppError appError = AppError(AppErrorType.initial);

  ProductNamesViewModel() {
    getData();
  }

  Future<void> getData() async {
    appError = AppError(AppErrorType.loading);
    Either response = await productRepository.getProductList();
    response.fold((l) => appError = l, (r) {
      appError = AppError(AppErrorType.initial);
      return productList = r;
    });
    notifyListeners();
  }

  Future<void> editProductList(
      {Product? oldProduct, required Product newProduct}) async {
    if (oldProduct != null) {
      productList.removeWhere((shop) => shop == oldProduct);
    }
    productList.add(newProduct);
    await productRepository.updateProductList(productList: productList);
    notifyListeners();
  }

  Future<void> deleteProduct({required Product product}) async {
    productList.removeWhere((pro) => pro == product);
    await productRepository.updateProductList(productList: productList);
    Either response =
        await targetRepository.getSaleTargetList(tranMonth: DateTime.now());
    response.fold((l) => appError = l, (r) => saleTargetList = r);
    saleTargetList.removeWhere((target) => target.productName == product.name);
    await targetRepository.updateSaleTargetList(targetList: saleTargetList);
    notifyListeners();
  }
}
