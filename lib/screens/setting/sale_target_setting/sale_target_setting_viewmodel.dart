import 'package:cholay_ice_sale/core/models/product.dart';
import 'package:cholay_ice_sale/core/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/models/app_error.dart';
import '../../../core/models/targets/sale_target.dart';
import '../../../core/models/targets/transport_target.dart';
import '../../../core/repositories/target_repository.dart';
import '../../../di/get_it.dart';

class SaleTargetSettingViewModel with ChangeNotifier {
  TargetRepository targetRepository = getItInstance<TargetRepository>();
  ProductRepository productRepository = getItInstance<ProductRepository>();

  List<SaleTarget> saleTargetList = [];
  List<Product> productList = [];
  AppError appError = AppError(AppErrorType.initial);
  SaleTargetSettingViewModel() {
    getData();
  }

  Future<void> getData() async {
    await addInitialTargets();
    appError = AppError(AppErrorType.loading);
    Either response =
        await targetRepository.getSaleTargetList(tranMonth: DateTime.now());
    response.fold(
      (l) {
        appError = AppError(AppErrorType.initial);
      },
      (r) {
        appError = AppError(AppErrorType.initial);

        r.forEach((element) {
          saleTargetList.removeWhere(
              (target) => target.productName == element.productName);
        });

        return saleTargetList.addAll(r);
      },
    );

    notifyListeners();
  }

  Future<void> addInitialTargets() async {
    Either response = await productRepository.getProductList();
    response.fold((l) => appError = l, (r) => productList = r);
    productList.forEach((product) {
      saleTargetList.add(SaleTarget(
          productName: product.name,
          targets: List.generate(
              3,
              (index) =>
                  TargetInfo(level: index + 1, amount: 0, pricePool: 0))));
    });
    notifyListeners();
  }

  Future<void> updateTargetList(SaleTarget saleTarget) async {
    appError = AppError(AppErrorType.loading);
    saleTargetList.removeWhere(
        (target) => (target.productName == saleTarget.productName));
    saleTargetList.add(saleTarget);
    await targetRepository.updateSaleTargetList(targetList: saleTargetList);
    appError = AppError(AppErrorType.initial);
  }
}
