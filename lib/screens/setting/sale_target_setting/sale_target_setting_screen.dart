import 'package:cholay_ice_sale/screens/setting/sale_target_setting/sale_target_setting_view.dart';
import 'package:cholay_ice_sale/screens/setting/sale_target_setting/sale_target_setting_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaleTargetSettingScreen extends StatelessWidget {
  const SaleTargetSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SaleTargetSettingViewModel(),
      child: SaleTargetSettingView(),
    );
  }
}
