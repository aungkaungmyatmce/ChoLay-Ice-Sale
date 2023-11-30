import 'package:cholay_ice_sale/commom/constants/style.dart';
import 'package:cholay_ice_sale/core/models/product.dart';
import 'package:cholay_ice_sale/core/repositories/product_repository.dart';
import 'package:cholay_ice_sale/core/services/draw_line_graph.dart';
import 'package:dartz/dartz.dart' show Either;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../di/get_it.dart';
import '../target_viewmodel.dart';

class ChartScreen extends StatefulWidget {
  ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  ProductRepository productRepository = getItInstance<ProductRepository>();
  List<Product> productList = [];
  bool isLoading = false;

  @override
  void initState() {
    getProductNames();
    super.initState();
  }

  Future<void> getProductNames() async {
    setState(() {
      isLoading = true;
    });
    Either response = await productRepository.getProductList();
    setState(() {
      isLoading = false;
    });
    response.fold((l) => (), (r) => productList = r);
  }

  @override
  Widget build(BuildContext context) {
    var targetViewModel =
        ModalRoute.of(context)?.settings.arguments as TargetViewModel;
    List<Map<String, dynamic>> allRouteList =
        targetViewModel.routeList(isAllList: true);
    List<int> xData = allRouteList
        .map((route) => int.parse(DateFormat('dd').format(route['date'])))
        .toList()
        .reversed
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Chart'),
      ),
      body: isLoading
          ? CircularProgressIndicator()
          : Column(
              children: [
                for (Product product in productList)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Text(product.name, style: secondaryTextStyle()),
                      SizedBox(height: 10),
                      DrawLineGraph(
                          xData: xData,
                          yData: allRouteList
                              .map((route) =>
                                  route['totalProducts'][product.name] as int)
                              .toList()
                              .reversed
                              .toList()),
                      SizedBox(height: 10),
                    ],
                  )
              ],
            ),
    );
  }
}
