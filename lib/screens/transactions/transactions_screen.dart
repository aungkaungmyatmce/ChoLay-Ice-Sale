import 'package:cholay_ice_sale/screens/transactions/transactions_view.dart';
import 'package:cholay_ice_sale/screens/transactions/transactions_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TransactionsViewModel(),
      child: TransactionsView(),
    );
  }
}
