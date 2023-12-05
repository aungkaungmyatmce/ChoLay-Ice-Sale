import 'package:cholay_ice_sale/screens/dashboard/dashboard_viewmodel.dart';
import 'package:cholay_ice_sale/screens/sale_analytics/sale_analytics_view.dart';
import 'package:cholay_ice_sale/screens/sale_analytics/sale_analytics_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaleAnalyticsScreen extends StatelessWidget {
  const SaleAnalyticsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<DashBoardViewModel,
        SaleAnalyticsViewModel>(
      create: (context) => SaleAnalyticsViewModel(),
      update: (_, dashBoardViewModel, saleAnalyticsViewModel) =>
          saleAnalyticsViewModel!
            ..updateMonth(dashBoardViewModel.selectedMonth),
      child: SaleAnalyticView(),
    );
  }
}
