import 'package:cholay_ice_sale/screens/setting/accounting/accounting_view.dart';
import 'package:cholay_ice_sale/screens/setting/accounting/accounting_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountingScreen extends StatelessWidget {
  const AccountingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AccountingViewModel(),
      child: AccountingView(),
    );
  }
}
