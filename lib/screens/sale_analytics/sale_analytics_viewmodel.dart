import 'package:cholay_ice_sale/core/models/app_error.dart';
import 'package:cholay_ice_sale/core/models/product.dart';
import 'package:cholay_ice_sale/core/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../core/models/customer.dart';
import '../../core/models/transactions/sale_transaction.dart';
import '../../core/repositories/customer_repository.dart';
import '../../core/repositories/transaction_repository.dart';
import '../../di/get_it.dart';

class SaleAnalyticsViewModel with ChangeNotifier {
  CustomerRepository customerRepository = getItInstance<CustomerRepository>();
  TransactionRepository transactionRepository =
      getItInstance<TransactionRepository>();
  ProductRepository productRepository = getItInstance<ProductRepository>();

  SaleAnalyticsViewModel() {
    getData();
  }

  DateTime selectedMonth = DateTime.now();
  List<Customer> customerList = [];
  List<Product> productList = [];
  List<SaleTransaction> saleTransactionList = [];

  AppError appError = AppError(AppErrorType.initial);

  void updateMonth(DateTime month) {
    selectedMonth = month;
    getData();
  }

  Future<void> getData() async {
    appError = AppError(AppErrorType.loading);

    notifyListeners();
    Either response = await customerRepository.getCustomerList();
    response.fold((l) => appError = l, (r) => customerList = r);

    response = await transactionRepository.getSaleTransactions(
        tranMonth: selectedMonth);
    response.fold((l) => appError = l, (r) => saleTransactionList = r);

    response = await productRepository.getProductList();
    response.fold((l) => appError = l, (r) => productList = r);

    appError = AppError(AppErrorType.initial);

    notifyListeners();
  }

  List<Map<String, dynamic>> routeList({bool isAllList = true}) {
    List<String> anisakhanCustomerList = [];
    List<String> productNames = [];
    Map<String, dynamic> productNameAndAmount = {};

    for (var customer in customerList) {
      if (customer.isInAnisakhan()) {
        anisakhanCustomerList.add(customer.name);
      }
    }

    saleTransactionList.forEach((tran) {
      if (!productNames.contains(tran.productName)) {
        productNames.add(tran.productName);
        productNameAndAmount.putIfAbsent(tran.productName, () => 0);
      }
    });

    List<Map<String, dynamic>> dailyRouteList = [];

    for (int day = 31; day >= 0; day--) {
      productNameAndAmount.forEach((key, value) {
        productNameAndAmount[key] = 0;
      });

      List<String> cusList = [];
      List<SaleTransaction> dayList = saleTransactionList
          .where((tran) => tran.tranDate.day == day)
          .toList();
      dayList.sort((a, b) => a.tranDate.compareTo(b.tranDate));
      if (!isAllList) {
        dayList.removeWhere(
            (tran) => anisakhanCustomerList.contains(tran.customerName));
      }

      if (dayList.isNotEmpty) {
        for (var dayTran in dayList) {
          productNameAndAmount[dayTran.productName] =
              productNameAndAmount[dayTran.productName] + dayTran.quantity;
          cusList.add(dayTran.customerName);
        }

        Map<String, dynamic> dayMap = {
          'date': dayList.first.tranDate.subtract(Duration(minutes: 15)),
          'totalCustomers': cusList.length,
          'totalProducts':
              productNameAndAmount.map((key, value) => MapEntry(key, value)),
        };
        dailyRouteList.add(dayMap);
      }
    }

    return dailyRouteList;
  }
}
