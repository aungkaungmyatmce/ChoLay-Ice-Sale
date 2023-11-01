import 'package:cholay_ice_sale/screens/order/order_view.dart';
import 'package:cholay_ice_sale/screens/order/order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderViewModel(),
      child: OrderView(),
    );
  }
}
