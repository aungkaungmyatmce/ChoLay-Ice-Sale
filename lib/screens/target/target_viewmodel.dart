import 'package:cholay_ice_sale/core/models/app_error.dart';
import 'package:cholay_ice_sale/core/models/customer.dart';
import 'package:cholay_ice_sale/core/models/targets/transport_target.dart';
import 'package:cholay_ice_sale/core/models/transactions/sale_transaction.dart';
import 'package:cholay_ice_sale/core/repositories/customer_repository.dart';
import 'package:cholay_ice_sale/core/repositories/target_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import '../../core/models/targets/sale_target.dart';
import '../../core/repositories/transaction_repository.dart';
import '../../di/get_it.dart';

class TargetViewModel with ChangeNotifier {
  TargetRepository targetRepository = getItInstance<TargetRepository>();
  TransactionRepository transactionRepository =
      getItInstance<TransactionRepository>();

  List<SaleTarget> saleTargetList = [];
  List<TransportTarget> transportTargetList = [];
  List<SaleTransaction> saleTransactionList = [];

  DateTime selectedMonth = DateTime.now();
  AppError appError = AppError(AppErrorType.initial);
  TargetViewModel() {
    getData();
  }

  Future<void> getData() async {
    saleTargetList = [];
    transportTargetList = [];
    saleTransactionList = [];
    appError = AppError(AppErrorType.loading);
    Either response =
        await targetRepository.getSaleTargetList(tranMonth: selectedMonth);
    response.fold((l) => appError = l, (r) => saleTargetList = r);

    response =
        await targetRepository.getTransportTargetList(tranMonth: selectedMonth);
    response.fold((l) => appError = l, (r) => transportTargetList = r);

    response = await transactionRepository.getSaleTransactions(
        tranMonth: selectedMonth);
    response.fold((l) => appError = l, (r) => saleTransactionList = r);

    if (saleTargetList.isEmpty && transportTargetList.isEmpty) {
      appError = AppError(AppErrorType.database);
      notifyListeners();
    } else {
      appError = AppError(AppErrorType.initial);
      notifyListeners();
    }
    notifyListeners();
  }

  void updateMonth(DateTime month) {
    selectedMonth = month;
    getData();
  }

  Map<String, int> productsSoldAmount() {
    Map<String, int> productSold = {};
    saleTargetList.forEach((tran) {
      productSold[tran.productName] = 0;
    });

    //productSold = saleTargetList.map((target) => target.productName).toList();

    saleTransactionList.forEach((tran) {
      if (productSold[tran.productName] != null) {
        productSold[tran.productName] =
            (productSold[tran.productName]! + tran.quantity);
      }
    });

    return productSold;
  }

  List<Map<String, dynamic>> transportTargetReach() {
    List<Map<String, dynamic>> targetReach = [];
    transportTargetList.forEach((target) {
      targetReach.add({
        'level': target.targetLevel,
        'startingTime': DateTime(
            2023, 12, 1, target.startingTime.hour, target.startingTime.minute),
        'reachDays': 0,
        'targetDays': target.days,
        'isReached': false,
      });
    });
    for (var transaction in saleTransactionList) {
      DateTime sendHour = DateTime(
          2023, 12, 1, transaction.tranDate.hour, transaction.tranDate.minute);
      for (var target in targetReach) {
        if (sendHour.isBefore(target['startingTime'])) {
          target['reachDays'] = target['reachDays'] + 1;
        }
        if (target['reachDays'] >= target['targetDays']) {
          target['isReached'] = true;
        }
      }
    }

    return targetReach;
  }
}
