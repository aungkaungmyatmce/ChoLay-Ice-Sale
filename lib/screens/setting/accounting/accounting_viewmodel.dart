import 'package:cholay_ice_sale/core/models/transactions/expense_transaction.dart';
import 'package:cholay_ice_sale/core/repositories/product_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../../core/models/app_error.dart';
import '../../../core/models/product.dart';
import '../../../core/models/transactions/sale_transaction.dart';
import '../../../core/repositories/transaction_repository.dart';
import '../../../di/get_it.dart';

class AccountingViewModel with ChangeNotifier {
  DateTime? selectedMonth = DateTime.now();
  final fs = FirebaseFirestore.instance;
  TransactionRepository transactionRepository =
      getItInstance<TransactionRepository>();
  ProductRepository productRepository = getItInstance<ProductRepository>();

  List<SaleTransaction> saleTransactionList = [];
  List<ExpenseTransaction> expenseTransactionList = [];
  List<Product> productList = [];
  AppError appError = AppError(AppErrorType.initial);

  bool isLoading = false;
  AccountingViewModel() {
    getData();
  }

  void updateMonth(DateTime month) {
    selectedMonth = month;
    getData();
  }

  Future<void> getData() async {
    saleTransactionList = [];
    expenseTransactionList = [];
    appError = AppError(AppErrorType.loading);
    notifyListeners();
    Either saleResponse = await transactionRepository.getSaleTransactions(
        tranMonth: selectedMonth!);
    saleResponse.fold((l) => appError = l, (r) {
      appError = AppError(AppErrorType.initial);

      return saleTransactionList = r;
    });

    Either expenseResponse = await transactionRepository.getExpenseTransactions(
        tranMonth: selectedMonth!);

    expenseResponse.fold((l) => appError = l, (r) {
      appError = AppError(AppErrorType.initial);
      return expenseTransactionList = r;
    });

    Either productResponse = await productRepository.getProductList();
    productResponse.fold((l) => appError = l, (r) {
      appError = AppError(AppErrorType.initial);
      return productList = r;
    });
    notifyListeners();
  }

  void changeMonth(DateTime month) async {
    selectedMonth = month;
    await getData();
    notifyListeners();
  }

  List<Map<String, dynamic>> saleTransactionsForOneMonth() {
    List<Map<String, dynamic>> mapList = [];
    productList.forEach((product) {
      int total = 0;
      saleTransactionList.forEach((tran) {
        if (tran.productName == product.name) {
          total += tran.quantity;
        }
      });
      mapList.add({
        'productName': product.name,
        'amount': total.toString(),
        'price': (total * product.price).toString(),
      });
    });
    return mapList;
  }

  Map<String, dynamic> totalSaleAndExpense() {
    int totalSales = 0;
    int totalExpense = 0;
    saleTransactionList.forEach((tran) {
      totalSales += tran.quantity * tran.price;
    });

    expenseTransactionList.forEach((tran) {
      totalExpense += tran.amount;
    });
    return {
      'totalSale': totalSales,
      'totalExpense': totalExpense,
      'netIncome': totalSales - totalExpense,
    };
  }

  List<Map<String, dynamic>> totalSaleAndExpenseDaily() {
    List<Map<String, dynamic>> dailyTranList = [];
    for (int day = 31; day >= 0; day--) {
      int totalSale = 0;
      int totalExpense = 0;
      List<SaleTransaction> daySaleList = saleTransactionList
          .where((tran) => tran.tranDate.day == day)
          .toList();
      List<ExpenseTransaction> dayExpList = expenseTransactionList
          .where((tran) => tran.tranDate.day == day)
          .toList();
      if (daySaleList.isNotEmpty) {
        for (var dayTran in daySaleList) {
          totalSale += dayTran.totalPrice;
        }
        for (var dayTran in dayExpList) {
          totalExpense += dayTran.amount;
        }

        Map<String, dynamic> dayMap = {
          'date': DateFormat('dd MMM')
              .format(daySaleList.first.tranDate)
              .toString(),
          'totalSale': totalSale.toString(),
          'totalExpense': totalExpense.toString(),
          'netIncome': (totalSale - totalExpense).toString(),
        };
        dailyTranList.add(dayMap);
      }
    }
    return dailyTranList.reversed.toList();
  }
}
