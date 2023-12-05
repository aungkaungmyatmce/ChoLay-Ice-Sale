import 'package:cholay_ice_sale/screens/add_order/add_order_screen.dart';
import 'package:cholay_ice_sale/screens/add_transaction/add_transaction_screen.dart';
import 'package:cholay_ice_sale/screens/dashboard/dashboard_screen.dart';
import 'package:cholay_ice_sale/screens/home/home_screen.dart';
import 'package:cholay_ice_sale/screens/language/change_language_screen.dart';
import 'package:cholay_ice_sale/screens/order/order_screen.dart';
import 'package:cholay_ice_sale/screens/printer/sale_print_screen.dart';
import 'package:cholay_ice_sale/screens/sale_analytics/sale_analytics_screen.dart';
import 'package:cholay_ice_sale/screens/setting/accounting/accounting_screen.dart';
import 'package:cholay_ice_sale/screens/setting/customer_names/customer_names_screen.dart';
import 'package:cholay_ice_sale/screens/setting/product_names/product_names_screen.dart';
import 'package:cholay_ice_sale/screens/setting/sale_target_setting/sale_target_setting_screen.dart';
import 'package:cholay_ice_sale/screens/setting/transport_target_setting/transport_target_setting_screen.dart';
import 'package:cholay_ice_sale/screens/dashboard/chart_screen.dart';
import 'package:cholay_ice_sale/screens/target/target_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../common/constants/route_constants.dart';
import 'account/login_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.initial: (context) {
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (ctx, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {}
                if (userSnapshot.hasData) {
                  return HomeScreen();
                }
                return LoginScreen();
              });
          return HomeScreen();
        },
        RouteList.homeScreen: (context) => Container(),
        RouteList.salePrintScreen: (context) => SalePrintScreen(),
        RouteList.addTransactionsScreen: (context) => AddTransactionScreen(),
        RouteList.orderScreen: (context) => OrderScreen(),
        RouteList.addOrderScreen: (context) => AddOrderScreen(),
        RouteList.saleScreen: (context) => Container(),
        RouteList.targetScreen: (context) => TargetScreen(),
        RouteList.dashBoardScreen: (context) => DashBoardScreen(),
        RouteList.saleAnalyticsScreen: (context) => SaleAnalyticsScreen(),
        RouteList.settingScreen: (context) => Container(),
        RouteList.chartScreen: (context) => ChartScreen(),
        RouteList.customerNamesScreen: (context) => CustomerNamesScreen(),
        RouteList.productNamesScreen: (context) => ProductNamesScreen(),
        RouteList.saleTargetSettingScreen: (context) =>
            SaleTargetSettingScreen(),
        RouteList.transportTargetSettingScreen: (context) =>
            TransportTargetSettingScreen(),
        RouteList.accountingScreen: (context) => AccountingScreen(),
        RouteList.languageChangeScreen: (context) => ChangeLanguageScreen(),
      };
}
