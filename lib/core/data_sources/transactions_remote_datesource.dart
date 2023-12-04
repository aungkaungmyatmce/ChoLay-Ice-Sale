import 'package:cholay_ice_sale/core/models/transactions/expense_transaction.dart';
import 'package:cholay_ice_sale/core/models/transactions/sale_transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

abstract class TransactionRemoteDataSource {
  Future<List<SaleTransaction>> getSaleTransactions(
      {required DateTime tranMonth});
  Future<void> addSaleTransaction(
      {required DateTime tranMonth, required SaleTransaction saleTran});
  Future<void> deleteSaleTransaction(
      {required DateTime tranMonth, required SaleTransaction saleTran});

  Future<List<ExpenseTransaction>> getExpenseTransactions(
      {required DateTime tranMonth});
  Future<void> addExpenseTransaction(
      {required DateTime tranMonth, required ExpenseTransaction expenseTran});
  Future<void> deleteExpenseTransaction(
      {required DateTime tranMonth, required ExpenseTransaction expenseTran});
  Stream<List<SaleTransaction>> saleTransactionStream(
      {required DateTime tranMonth});
}

class TransactionRemoteDataSourceImpl extends TransactionRemoteDataSource {
  CollectionReference transactionCollection =
      FirebaseFirestore.instance.collection('allTransactions');

  @override
  Future<List<SaleTransaction>> getSaleTransactions(
      {required DateTime tranMonth}) async {
    List<SaleTransaction> tranList = [];
    QuerySnapshot snapshot = await transactionCollection
        .doc(DateFormat.yMMM().format(tranMonth).toString())
        .collection('saleTransactions')
        .get();
    List docList = snapshot.docs;

    if (docList.isEmpty) {
      throw Exception();
    }
    docList.map((doc) {
      tranList.add(SaleTransaction.fromJson(doc));
    }).toList();
    return tranList;
  }

  @override
  Future<void> addSaleTransaction(
      {required DateTime tranMonth, required SaleTransaction saleTran}) async {
    await transactionCollection
        .doc(DateFormat.yMMM().format(tranMonth).toString())
        .collection('saleTransactions')
        .add(saleTran.toJson());
  }

  @override
  Future<void> deleteSaleTransaction(
      {required DateTime tranMonth, required SaleTransaction saleTran}) async {
    final response = await transactionCollection
        .doc(DateFormat.yMMM().format(tranMonth).toString())
        .collection('saleTransactions')
        .doc(saleTran.tranId)
        .delete();
    return response;
  }

  @override
  Future<List<ExpenseTransaction>> getExpenseTransactions(
      {required DateTime tranMonth}) async {
    List<ExpenseTransaction> tranList = [];
    QuerySnapshot snapshot = await transactionCollection
        .doc(DateFormat.yMMM().format(tranMonth).toString())
        .collection('expenseTransactions')
        .get(GetOptions(source: Source.serverAndCache));

    List docList = snapshot.docs;

    if (docList.isEmpty) {
      throw Exception();
    }
    docList.map((doc) {
      tranList.add(ExpenseTransaction.fromJson(doc));
    }).toList();
    return tranList;
  }

  @override
  Future<void> addExpenseTransaction(
      {required DateTime tranMonth,
      required ExpenseTransaction expenseTran}) async {
    await transactionCollection
        .doc(DateFormat.yMMM().format(tranMonth).toString())
        .collection('expenseTransactions')
        .add(expenseTran.toJson());
  }

  @override
  Future<void> deleteExpenseTransaction(
      {required DateTime tranMonth,
      required ExpenseTransaction expenseTran}) async {
    final response = await transactionCollection
        .doc(DateFormat.yMMM().format(tranMonth).toString())
        .collection('saleTransactions')
        .doc(expenseTran.tranId)
        .delete();
    return response;
  }

  Stream<List<SaleTransaction>> saleTransactionStream(
      {required DateTime tranMonth}) async* {
    List<SaleTransaction> tranList = [];
    await for (var snapshot in transactionCollection
        .doc(DateFormat.yMMM().format(tranMonth).toString())
        .collection('saleTransactions')
        .snapshots()) {
      tranList = [];
      List docList = snapshot.docs;

      // if (docList.isEmpty) {
      //   throw Exception();
      // }
      docList.map((doc) {
        tranList.add(SaleTransaction.fromJson(doc));
      }).toList();
      yield tranList;
    }
  }
}
