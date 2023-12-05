import 'package:cholay_ice_sale/core/models/app_error.dart';
import 'package:dartz/dartz.dart' hide Order;
import 'package:flutter/material.dart';

import '../../core/models/order.dart';
import '../../core/models/transactions/sale_transaction.dart';
import '../../core/repositories/order_repository.dart';
import '../../core/repositories/transaction_repository.dart';
import '../../di/get_it.dart';

class OrderViewModel with ChangeNotifier {
  OrderRepository orderRepository = getItInstance<OrderRepository>();
  TransactionRepository transactionRepository =
      getItInstance<TransactionRepository>();

  //List<Order> orderList = [];
  List<SaleTransaction> saleTranList = [];
  AppError appError = AppError(AppErrorType.initial);
  OrderViewModel() {
    //getOrders();
    getSaleTransactions();
  }

  // Future<void> getOrders() async {
  //   appError = AppError(AppErrorType.loading);
  //   Either response = await orderRepository.getOrderList();
  //   response.fold((l) => appError = l, (r) {
  //     appError = AppError(AppErrorType.initial);
  //     return orderList = r;
  //   });
  //
  //   orderList.sort((a, b) => a.orderTime.compareTo(b.orderTime));
  //   notifyListeners();
  // }

  Future<void> getSaleTransactions() async {
    appError = AppError(AppErrorType.loading);
    Either response = await transactionRepository.getSaleTransactions(
        tranMonth: DateTime.now());
    response.fold((l) => appError = l, (r) => saleTranList = r);

    response = await transactionRepository.getSaleTransactions(
        tranMonth: DateTime.now().subtract(const Duration(days: 30)));
    response.fold((l) => appError = l, (r) {
      saleTranList.addAll(r);
    });
    notifyListeners();
  }

  Future<void> deleteOrder(Order order) async {
    await orderRepository.deleteOrder(order: order);
    //orderList.remove(order);
    //notifyListeners();
  }

  List<Map<String, dynamic>> customerSuggestList() {
    List<Map<String, dynamic>> shopsToCallList = [];
    List<String> shopNames = [];
    List<SaleTransaction> tranList = saleTranList;

    for (var tran in tranList) {
      if (!shopNames.contains(tran.customerName)) {
        shopNames.add(tran.customerName);
      }
    }

    for (var shop in shopNames) {
      List<int> numList = [];
      int orderHabit = 0;
      List<SaleTransaction> tranListForShop =
          tranList.where((tran) => tran.customerName == shop).toList();
      tranListForShop.sort((b, a) => a.tranDate.compareTo(b.tranDate));

      for (var shop in tranListForShop) {
        if (shop != tranListForShop.last) {
          DateTime from = DateTime(
              shop.tranDate.year, shop.tranDate.month, shop.tranDate.day);
          DateTime to = DateTime(
              tranListForShop[tranListForShop.indexOf(shop) + 1].tranDate.year,
              tranListForShop[tranListForShop.indexOf(shop) + 1].tranDate.month,
              tranListForShop[tranListForShop.indexOf(shop) + 1].tranDate.day);
          int dayDifference = from.difference(to).inDays;
          if (dayDifference != 0) {
            numList.add(dayDifference);
          }
        }
      }

      if (numList.isNotEmpty) {
        if (numList.length > 4) {
          numList = numList.getRange(0, 4).toList();
        }
        for (int i in numList) {
          orderHabit += i;
        }
        orderHabit =
            int.parse((orderHabit / numList.length).toStringAsFixed(0));
        //print(orderHabit);
        // print(DateTime.now()
        //     .difference(tranListForShop.first.sellingDate!)
        //     .inDays);
        if ((DateTime.now()
                    .difference(DateTime(
                        tranListForShop.first.tranDate.year,
                        tranListForShop.first.tranDate.month,
                        tranListForShop.first.tranDate.day))
                    .inDays >=
                orderHabit) &&
            (DateTime.now().difference(tranListForShop.first.tranDate).inDays -
                    orderHabit) <
                5) {
          Map<String, dynamic> shopToCall = {
            'name': shop,
            'last order': DateTime.now()
                .difference(DateTime(
                    tranListForShop.first.tranDate.year,
                    tranListForShop.first.tranDate.month,
                    tranListForShop.first.tranDate.day))
                .inDays,
            'order habit': orderHabit,
            'day difference': DateTime.now()
                    .difference(DateTime(
                        tranListForShop.first.tranDate.year,
                        tranListForShop.first.tranDate.month,
                        tranListForShop.first.tranDate.day))
                    .inDays -
                orderHabit,
          };
          if (shopToCall['name'] != 'အိမ်' && shopToCall['name'] != 'Chue') {
            shopsToCallList.add(shopToCall);
          }
        }
      }
    }

    shopsToCallList
        .sort((a, b) => a['day difference'].compareTo(b['day difference']));

    return shopsToCallList;
  }
}
