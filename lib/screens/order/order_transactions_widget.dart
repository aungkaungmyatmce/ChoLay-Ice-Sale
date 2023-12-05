import 'package:cholay_ice_sale/common/constants/translation_constants.dart';
import 'package:cholay_ice_sale/common/extensions/string_extensions.dart';
import 'package:cholay_ice_sale/common/themes/app_color.dart';
import 'package:cholay_ice_sale/core/services/confirm_delete_tran.dart';
import 'package:cholay_ice_sale/screens/order/order_viewmodel.dart';
import 'package:cholay_ice_sale/widgets/body_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/constants/decoration.dart';
import '../../common/constants/route_constants.dart';
import '../../common/constants/style.dart';
import '../../core/models/order.dart';

class OrderTransactionsWidget extends StatelessWidget {
  const OrderTransactionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context, listen: false);
    List<Order> orderList = [];
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('orderList').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}',
                style: secondaryTextStyle());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            );
          }
          final docList = snapshot.data!.docs.map((doc) => doc).toList();
          orderList = docList
              .map((doc) {
                return Order.fromJson(doc);
              })
              .cast<Order>()
              .toList();
          if (orderList.isEmpty) {
            return Center(
                child: Text(TranslationConstants.noOrders.t(context),
                    style: secondaryTextStyle()));
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: orderList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  var isPrint = await Navigator.of(context).pushNamed(
                      RouteList.salePrintScreen,
                      arguments: orderList[index]);
                  if (isPrint == true) {
                    orderViewModel.deleteOrder(orderList[index]);
                  }
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    // padding: const EdgeInsets.all(10),
                    decoration: boxDecorationRoundedWithShadow(12),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      orderList[index].customerName,
                                      style: secondaryTextStyle(size: 15),
                                    ),
                                    Spacer(),
                                    Text(
                                        DateFormat('dd-MM  hh:mm a')
                                            .format(orderList[index].orderTime)
                                            .toString(),
                                        style: boldTextStyle(
                                            weight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  if (await confirmDeleteTran(context)) {
                                    orderViewModel
                                        .deleteOrder(orderList[index]);
                                  }
                                },
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                        const Divider(),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(10.0),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: orderList[index].products.length,
                          itemBuilder: (context, index2) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      orderList[index]
                                          .products[index2]
                                          .productName,
                                      style: secondaryTextStyle()),
                                  Text(
                                      orderList[index]
                                          .products[index2]
                                          .quantity
                                          .toString(),
                                      style: secondaryTextStyle()),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
