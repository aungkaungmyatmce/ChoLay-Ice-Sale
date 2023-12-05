import 'package:cholay_ice_sale/core/models/app_error.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/models/transactions/expense_transaction.dart';
import '../../core/models/transactions/sale_transaction.dart';
import '../../core/repositories/transaction_repository.dart';
import '../../di/get_it.dart';

class SaleTransactionsViewModel with ChangeNotifier {
  DateTime? selectedMonth = DateTime.now();
  final fs = FirebaseFirestore.instance;
  TransactionRepository transactionRepository =
      getItInstance<TransactionRepository>();

  List<SaleTransaction> saleTransactionList = [];
  AppError appError = AppError(AppErrorType.initial);

  bool isLoading = false;
  SaleTransactionsViewModel() {
    getData();
  }

  void updateMonth(DateTime month) {
    selectedMonth = month;
    getData();
  }

  Future<void> getData() async {
    await for (var saleTranList in transactionRepository.saleTransactionStream(
        tranMonth: selectedMonth!)) {
      saleTransactionList = saleTranList;

      if (saleTransactionList.isEmpty) {
        appError = AppError(AppErrorType.database);
        notifyListeners();
      } else {
        appError = AppError(AppErrorType.initial);
        notifyListeners();
      }
    }

    // Either saleResponse = await transactionRepository.getSaleTransactions(
    //     tranMonth: selectedMonth);
    // Either expenseResponse = await transactionRepository.getExpenseTransactions(
    //     tranMonth: selectedMonth);
    // saleResponse.fold((l) => AppError(l), (r) => saleTransactionList = r);
    // expenseResponse.fold(
    //     (l) => AppError(l.appErrorType), (r) => expenseTransactionList = r);
  }

  List<Map<String, dynamic>> saleTransactionsForOneMonth() {
    List<SaleTransaction> dayTranList = saleTransactionList
        .where((tran) =>
            tran.tranDate.year == selectedMonth?.year &&
            tran.tranDate.month == selectedMonth?.month)
        .toList();

    List<Map<String, dynamic>> dailyTranList = [];

    for (int day = 31; day >= 0; day--) {
      int totalSum = 0;
      int totalNumber = 0;
      List<SaleTransaction> dayList =
          dayTranList.where((tran) => tran.tranDate.day == day).toList();
      dayList.sort((a, b) => a.tranDate.compareTo(b.tranDate));
      if (dayList.isNotEmpty) {
        for (var dayTran in dayList) {
          totalSum += dayTran.totalPrice!;
          totalNumber += dayTran.totalPrice!;
        }
        Map<String, dynamic> dayMap = {
          'date': DateFormat('dd MMM, yyyy')
              .format(dayList.first.tranDate)
              .toString(),
          'tranList': dayList,
          'totalNum': totalNumber.toString(),
          'totalSum': totalSum.toString(),
        };
        dailyTranList.add(dayMap);
      }
    }
    return dailyTranList;
  }

  Future<void> deleteSaleTran(SaleTransaction tran) async {
    await transactionRepository.deleteSaleTransaction(
        tranMonth: selectedMonth!, saleTran: tran);
    notifyListeners();
  }
}
