import 'package:cholay_ice_sale/screens/order/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/data_sources/product_remote_datasource.dart';
import '../transactions/transactions_screen.dart';

class HomeViewModel with ChangeNotifier {
  int _counter = 0;
  int selectedPos = 0;
  List<Widget> pages = [];
  int get counter => _counter;
  List list = [];
  ProductRemoteDataSourceImpl productRemoteDataSourceImpl =
      ProductRemoteDataSourceImpl();

  HomeViewModel() {
    print('Home init');
    init();

    _counter = 0;
  }

  void init() async {
    pages = [
      OrderScreen(),
      TransactionsScreen(),
      Container(color: Colors.green),
      Container(color: Colors.yellow),
    ];
    list = await productRemoteDataSourceImpl.getProductList();
  }

  void changePos(int pos) {
    selectedPos = pos;
    notifyListeners();
  }

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }
}
