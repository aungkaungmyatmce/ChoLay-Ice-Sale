import 'package:cholay_ice_sale/commom/themes/app_color.dart';
import 'package:cholay_ice_sale/screens/target/target_viewmodel.dart';
import 'package:cholay_ice_sale/screens/target/widgets/chart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../commom/constants/decoration.dart';
import '../../../commom/constants/route_constants.dart';
import '../../../commom/constants/style.dart';

class RoutesWidget extends StatelessWidget {
  const RoutesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final targetViewModel = Provider.of<TargetViewModel>(context);
    List<Map<String, dynamic>> allRouteList =
        targetViewModel.routeList(isAllList: true);
    List<Map<String, dynamic>> orderRouteList =
        targetViewModel.routeList(isAllList: false);

    return DefaultTabController(
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
                  width: 130,
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
                    tabs: const [
                      Tab(
                        child: Text(
                          'All',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Order',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(RouteList.chartScreen,
                          arguments: targetViewModel);
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
                              Text('Total Shops delivered',
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Starting Time',
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
                              Text('Total Shops delivered',
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
    );
  }
}
