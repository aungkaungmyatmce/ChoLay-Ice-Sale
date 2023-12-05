import 'package:cholay_ice_sale/screens/target/target_view.dart';
import 'package:cholay_ice_sale/screens/target/target_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dashboard/dashboard_viewmodel.dart';

class TargetScreen extends StatelessWidget {
  const TargetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<DashBoardViewModel, TargetViewModel>(
      create: (context) => TargetViewModel(),
      update: (_, dashBoardViewModel, targetViewModel) =>
          targetViewModel!..updateMonth(dashBoardViewModel.selectedMonth),
      child: TargetView(),
    );
  }
}
