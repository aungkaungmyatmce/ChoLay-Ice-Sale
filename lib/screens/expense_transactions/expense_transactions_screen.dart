import 'package:cholay_ice_sale/screens/expense_transactions/expense_transactions_view.dart';
import 'package:cholay_ice_sale/screens/expense_transactions/expense_transactions_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../transactions/transactions_viewmodel.dart';

class ExpenseTransactionsScreen extends StatelessWidget {
  const ExpenseTransactionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<TransactionsViewModel,
        ExpenseTransactionsViewModel>(
      create: (contex) => ExpenseTransactionsViewModel(),
      update: (_, transactionsViewModel, expenseTransactionsViewModel) =>
          expenseTransactionsViewModel!
            ..updateMonth(transactionsViewModel.selectedMonth),
      child: ExpenseTransactionsView(),
    );
  }
}
