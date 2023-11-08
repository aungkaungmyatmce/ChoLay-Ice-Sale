import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/models/app_error.dart';
import '../../core/models/transactions/expense_transaction.dart';
import '../../core/repositories/transaction_repository.dart';
import '../../di/get_it.dart';

class ExpenseTransactionsViewModel with ChangeNotifier {
  TransactionRepository transactionRepository =
      getItInstance<TransactionRepository>();

  List<ExpenseTransaction> expenseTransactionList = [];
  DateTime? selectedMonth = DateTime.now();
  bool isLoading = false;
  ExpenseTransactionsViewModel() {
    getData();
  }

  void updateMonth(DateTime month) {
    selectedMonth = month;
    getData();
  }

  Future<void> getData() async {
    Either expenseResponse = await transactionRepository.getExpenseTransactions(
        tranMonth: selectedMonth!);
    expenseResponse.fold(
        (l) => AppError(l.appErrorType), (r) => expenseTransactionList = r);
    notifyListeners();
  }

  void changeMonth(DateTime month) {
    selectedMonth = month;
    getData();
    notifyListeners();
  }

  List<Map<String, dynamic>> expenseTransactionsForOneMonth() {
    List<ExpenseTransaction> dayTranList = expenseTransactionList
        .where((tran) =>
            tran.tranDate.year == selectedMonth?.year &&
            tran.tranDate.month == selectedMonth?.month)
        .toList();

    List<Map<String, dynamic>> dailyTranList = [];

    for (int day = 31; day >= 0; day--) {
      int totalSum = 0;

      List<ExpenseTransaction> dayList =
          dayTranList.where((tran) => tran.tranDate.day == day).toList();
      if (dayList.isNotEmpty) {
        for (var dayTran in dayList) {
          totalSum += dayTran.amount;
        }
        Map<String, dynamic> dayMap = {
          'date': DateFormat('dd MMMM, yyyy')
              .format(dayList.first.tranDate)
              .toString(),
          'tranList': dayList,
          'totalSum': totalSum.toString(),
        };
        dailyTranList.add(dayMap);
      }
    }
    return dailyTranList;
  }
}
