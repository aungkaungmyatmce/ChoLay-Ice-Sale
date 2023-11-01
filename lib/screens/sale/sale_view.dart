import 'package:cholay_ice_sale/screens/sale/sale_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaleView extends StatelessWidget {
  const SaleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final saleViewModel = Provider.of<SaleViewModel>(context);
    return Scaffold(
      body: Container(
        color: Colors.teal,
      ),
    );
  }
}
