import 'package:cholay_ice_sale/screens/target/target_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TargetView extends StatelessWidget {
  const TargetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final targetViewModel = Provider.of<TargetViewModel>(context);
    return Scaffold(
      body: Container(
        color: Colors.yellow,
      ),
    );
  }
}
