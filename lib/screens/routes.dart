import 'package:cholay_ice_sale/screens/add_order/add_order_screen.dart';
import 'package:cholay_ice_sale/screens/add_transaction/add_transaction_screen.dart';
import 'package:cholay_ice_sale/screens/home/home_screen.dart';
import 'package:cholay_ice_sale/screens/order/order_screen.dart';
import 'package:cholay_ice_sale/screens/printer/sale_print_screen.dart';
import 'package:cholay_ice_sale/screens/target/widgets/chart_screen.dart';
import 'package:flutter/material.dart';

import '../commom/constants/route_constants.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.initial: (context) => HomeScreen(),
        RouteList.homeScreen: (context) => Container(),
        RouteList.salePrintScreen: (context) => SalePrintScreen(),
        RouteList.addTransactionsScreen: (context) => AddTransactionScreen(),
        RouteList.orderScreen: (context) => OrderScreen(),
        RouteList.addOrderScreen: (context) => AddOrderScreen(),
        RouteList.saleScreen: (context) => Container(),
        RouteList.targetScreen: (context) => Container(),
        RouteList.settingScreen: (context) => Container(),
        RouteList.chartScreen: (context) => ChartScreen(),
      };
}
