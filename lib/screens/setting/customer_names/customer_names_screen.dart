import 'package:cholay_ice_sale/screens/setting/customer_names/customer_names_view.dart';
import 'package:cholay_ice_sale/screens/setting/customer_names/customer_names_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerNamesScreen extends StatelessWidget {
  const CustomerNamesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomerNamesViewModel(),
      child: CustomerNamesView(),
    );
  }
}
