import 'package:cholay_ice_sale/core/services/printer_service.dart';
import 'package:cholay_ice_sale/screens/printer/sale_print_view.dart';
import 'package:cholay_ice_sale/screens/printer/sale_print_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/order.dart';

class SalePrintScreen extends StatefulWidget {
  const SalePrintScreen({Key? key}) : super(key: key);

  @override
  State<SalePrintScreen> createState() => _SalePrintScreenState();
}

class _SalePrintScreenState extends State<SalePrintScreen> {
  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context)?.settings.arguments == null
        ? null
        : ModalRoute.of(context)?.settings.arguments as Order;

    return ChangeNotifierProvider(
      create: (context) => SalePrintViewModel(order: arguments),
      child: SalePrintView(),
    );
    // return ChangeNotifierProxyProvider<PrinterService, SalePrintViewModel>(
    //   create: (contex) => SalePrintViewModel(
    //       PrinterService()), // Initialize ProviderB with an empty string
    //   update: (context, PrinterService, salePrintViewModel) {
    //     return SalePrintViewModel(PrinterService);
    //   },
    //   child: SalePrintView(),
    // );
  }
}
