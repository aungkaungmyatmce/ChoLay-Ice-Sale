import 'package:cholay_ice_sale/screens/setting/product_names/product_names_view.dart';
import 'package:cholay_ice_sale/screens/setting/product_names/product_names_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductNamesScreen extends StatelessWidget {
  const ProductNamesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductNamesViewModel(),
      child: ProductNamesView(),
    );
  }
}
