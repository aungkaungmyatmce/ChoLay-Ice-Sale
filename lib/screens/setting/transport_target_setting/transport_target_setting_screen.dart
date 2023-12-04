import 'package:cholay_ice_sale/screens/setting/transport_target_setting/transport_target_setting_view.dart';
import 'package:cholay_ice_sale/screens/setting/transport_target_setting/transport_target_setting_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransportTargetSettingScreen extends StatelessWidget {
  const TransportTargetSettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TransportTargetSettingViewModel(),
      child: TransportTargetSettingView(),
    );
  }
}
