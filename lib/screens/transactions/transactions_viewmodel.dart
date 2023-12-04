import 'package:cholay_ice_sale/core/models/transactions/expense_transaction.dart';
import 'package:cholay_ice_sale/core/models/transactions/sale_transaction.dart';
import 'package:cholay_ice_sale/core/repositories/transaction_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../common/constants/route_constants.dart';
import '../../di/get_it.dart';

class TransactionsViewModel with ChangeNotifier {
  late TabController tabController;

  DateTime selectedMonth = DateTime.now();

  TransactionsViewModel() {}

  void changeMonth(DateTime month) {
    selectedMonth = month;
    notifyListeners();
  }

  void navigate(BuildContext context) async {
    var data = await Navigator.of(context).pushNamed(
      RouteList.addTransactionsScreen,
    );
    if (data == true) {
      notifyListeners();
    }
  }
}
