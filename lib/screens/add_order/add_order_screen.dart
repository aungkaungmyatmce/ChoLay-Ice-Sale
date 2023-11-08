import 'package:cholay_ice_sale/screens/add_order/add_order_view.dart';
import 'package:cholay_ice_sale/screens/add_order/add_order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddOrderScreen extends StatelessWidget {
  const AddOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddOrderViewModel(),
      child: AddOrderView(),
    );
  }
}
