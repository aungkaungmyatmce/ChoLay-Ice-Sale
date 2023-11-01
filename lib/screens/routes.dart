import 'package:cholay_ice_sale/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../commom/constants/route_constants.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
        RouteList.initial: (context) => HomeScreen(),
        RouteList.homeScreen: (context) => Container(),
        RouteList.orderScreen: (context) => Container(),
        RouteList.saleScreen: (context) => Container(),
        RouteList.targetScreen: (context) => Container(),
        RouteList.settingScreen: (context) => Container(),
      };
}
