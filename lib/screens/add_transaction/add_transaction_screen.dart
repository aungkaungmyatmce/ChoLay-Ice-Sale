import 'package:cholay_ice_sale/screens/add_transaction/add_transaction_view.dart';
import 'package:cholay_ice_sale/screens/add_transaction/add_transaction_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddTransactionViewModel(),
      child: AddTransactionView(),
    );
  }
}
