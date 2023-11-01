import 'package:cholay_ice_sale/screens/order/order_screen.dart';
import 'package:cholay_ice_sale/screens/sale/sale_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeViewModel with ChangeNotifier {
  int _counter = 0;
  int selectedPos = 0;
  List<Widget> pages = [];
  int get counter => _counter;

  HomeViewModel() {
    print('Home init');
    init();
    _counter = 0;
  }

  void init() {
    pages = [
      OrderScreen(),
      SaleScreen(),
      Container(color: Colors.green),
      Container(color: Colors.yellow),
    ];
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
