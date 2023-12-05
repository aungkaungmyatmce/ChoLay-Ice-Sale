import 'package:cholay_ice_sale/common/extensions/string_extensions.dart';
import 'package:cholay_ice_sale/screens/sale_analytics/sale_analytics_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/constants/route_constants.dart';
import '../../common/constants/style.dart';
import '../../common/constants/translation_constants.dart';
import '../../common/themes/app_color.dart';
import '../../widgets/body_widget.dart';

class SaleAnalyticView extends StatelessWidget {
  const SaleAnalyticView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final saleAnalyticsViewModel = Provider.of<SaleAnalyticsViewModel>(context);
    List<Map<String, dynamic>> allRouteList =
        saleAnalyticsViewModel.routeList(isAllList: true);
    List<Map<String, dynamic>> orderRouteList =
        saleAnalyticsViewModel.routeList(isAllList: false);

    print(saleAnalyticsViewModel.appError);
    return BodyWidget(
      appError: saleAnalyticsViewModel.appError,
      child: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 160,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TabBar(
                      padding: EdgeInsets.all(0),
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: AppColor.primaryColor),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(
                          child: Text(
                            TranslationConstants.all.t(context),
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Tab(
                          child: Text(
                            TranslationConstants.orders.t(context),
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(RouteList.chartScreen,
                            arguments: saleAnalyticsViewModel);
                      },
                      icon: Icon(
                        Icons.add_chart,
                        color: AppColor.primaryColor,
                      ))
                ],
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                SingleChildScrollView(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 0),
                    itemCount: orderRouteList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        //margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        //decoration: boxDecorationRoundedWithShadow(12),
                        child: Column(
                          children: [
                            Text(
                                DateFormat('dd MMMM, yyyy')
                                    .format(allRouteList[index]['date'])
                                    .toString(),
                                style: boldTextStyle(
                                    weight: FontWeight.w600,
                                    size: 14,
                                    color: AppColor.primaryColor)),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    TranslationConstants.totalShopsSold
                                        .t(context),
                                    style: boldTextStyle(size: 14)),
                                Text(
                                    allRouteList[index]['totalCustomers']
                                        .toString(),
                                    style: boldTextStyle(size: 14)),
                              ],
                            ),
                            SizedBox(height: 5),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  allRouteList[index]['totalProducts'].length,
                              itemBuilder: (context, index2) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        '${allRouteList[index]['totalProducts'].keys.elementAt(index2)}',
                                        style: boldTextStyle(size: 14)),
                                    Text(
                                        '${allRouteList[index]['totalProducts'].values.elementAt(index2)}',
                                        style: boldTextStyle(size: 14)),
                                  ],
                                );
                              },
                            ),
                            SizedBox(height: 10),
                            Divider(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SingleChildScrollView(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 0),
                    itemCount: orderRouteList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        //margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        //decoration: boxDecorationRoundedWithShadow(12),
                        child: Column(
                          children: [
                            Text(
                                DateFormat('dd MMMM, yyyy')
                                    .format(orderRouteList[index]['date'])
                                    .toString(),
                                style: boldTextStyle(
                                    weight: FontWeight.w600,
                                    size: 14,
                                    color: AppColor.primaryColor)),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    TranslationConstants.deliStartingTime
                                        .t(context),
                                    style: boldTextStyle(size: 14)),
                                Text(
                                    DateFormat('hh : mm a')
                                        .format(orderRouteList[index]['date'])
                                        .toString(),
                                    style: boldTextStyle(size: 14)),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    TranslationConstants.totalShopsSold
                                        .t(context),
                                    style: boldTextStyle(size: 14)),
                                Text(
                                    orderRouteList[index]['totalCustomers']
                                        .toString(),
                                    style: boldTextStyle(size: 14)),
                              ],
                            ),
                            SizedBox(height: 5),
                            ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      SizedBox(height: 5),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  orderRouteList[index]['totalProducts'].length,
                              itemBuilder: (context, index2) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        '${orderRouteList[index]['totalProducts'].keys.elementAt(index2)}',
                                        style: boldTextStyle(size: 14)),
                                    Text(
                                        '${orderRouteList[index]['totalProducts'].values.elementAt(index2)}',
                                        style: boldTextStyle(size: 14)),
                                  ],
                                );
                              },
                            ),
                            SizedBox(height: 10),
                            Divider(),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
