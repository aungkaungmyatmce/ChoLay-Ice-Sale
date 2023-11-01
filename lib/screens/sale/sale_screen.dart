import 'package:cholay_ice_sale/screens/sale/sale_view.dart';
import 'package:cholay_ice_sale/screens/sale/sale_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaleScreen extends StatelessWidget {
  const SaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SaleViewModel(),
      child: SaleView(),
    );
  }
}
