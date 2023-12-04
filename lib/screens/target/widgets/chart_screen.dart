import 'package:cholay_ice_sale/common/constants/style.dart';
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
        actions: [
          Align(
            child: Container(
              height: 40,
              padding: const EdgeInsets.all(10),
              //decoration: boxDecoration(radius: 8, showShadow: true),
              child: Row(
                children: [
                  Text(
                    DateFormat.yMMM().format(targetViewModel.selectedMonth),
                    style: secondaryTextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.date_range,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: isLoading
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Summary', style: secondaryTextStyle(size: 16)),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(height: 5),
                          itemCount: productList.length,
                          itemBuilder: (context, index) {
                            List<int> productQuantityList = allRouteList
                                .map((route) => route['totalProducts']
                                            [productList[index].name] ==
                                        null
                                    ? 0
                                    : route['totalProducts']
                                        [productList[index].name] as int)
                                .toList();
                            int total = productQuantityList
                                .reduce((value, element) => value + element);
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(productList[index].name,
                                    style: secondaryTextStyle()),
                                Text(total.toString(),
                                    style: secondaryTextStyle())
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Divider(),
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
                                    route['totalProducts'][product.name] == null
                                        ? 0
                                        : route['totalProducts'][product.name]
                                            as int)
                                .toList()
                                .reversed
                                .toList()),
                        SizedBox(height: 10),
                        Divider()
                      ],
                    ),
                  SizedBox(height: 10),
                  Text('Customers', style: secondaryTextStyle()),
                  SizedBox(height: 10),
                  DrawLineGraph(
                    xData: xData,
                    yData: allRouteList
                        .map((route) => route['totalCustomers'] as int)
                        .toList()
                        .reversed
                        .toList(),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                ],
              ),
            ),
    );
  }
}
