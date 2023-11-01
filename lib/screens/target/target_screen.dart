import 'package:cholay_ice_sale/screens/target/target_view.dart';
import 'package:cholay_ice_sale/screens/target/target_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TargetScreen extends StatelessWidget {
  const TargetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TargetViewModel(),
      child: TargetView(),
    );
  }
}
