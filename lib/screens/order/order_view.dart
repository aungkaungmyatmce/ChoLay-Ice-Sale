import 'package:cholay_ice_sale/screens/order/order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderView extends StatelessWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context);
    return Scaffold(
      body: Container(
        color: Colors.red,
      ),
    );
  }
}
