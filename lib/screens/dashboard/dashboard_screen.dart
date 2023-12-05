import 'package:cholay_ice_sale/screens/dashboard/dashboard_view.dart';
import 'package:cholay_ice_sale/screens/dashboard/dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashBoardViewModel(),
      child: DashBoardView(),
    );
  }
}
