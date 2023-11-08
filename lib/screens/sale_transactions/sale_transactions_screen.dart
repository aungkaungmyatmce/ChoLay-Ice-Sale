import '../transactions/transactions_viewmodel.dart';
import 'sale_transactions_view.dart';
import 'sale_transactions_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaleTransactionsScreen extends StatelessWidget {
  const SaleTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<TransactionsViewModel,
        SaleTransactionsViewModel>(
      create: (contex) => SaleTransactionsViewModel(),
      update: (_, transactionsViewModel, saleTransactionsViewModel) =>
          saleTransactionsViewModel!
            ..updateMonth(transactionsViewModel.selectedMonth),
      child: SaleTransactionsView(),
    );
  }
}
