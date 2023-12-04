import 'package:cholay_ice_sale/common/constants/translation_constants.dart';
import 'package:cholay_ice_sale/common/extensions/string_extensions.dart';
import 'package:cholay_ice_sale/screens/order/customer_suggestions_widget.dart';
import 'package:cholay_ice_sale/screens/order/order_transactions_widget.dart';
import 'package:cholay_ice_sale/screens/order/order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants/route_constants.dart';
import '../../common/constants/style.dart';
import '../../common/themes/app_color.dart';

class OrderView extends StatelessWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context);
    return SafeArea(
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text(TranslationConstants.orders.t(context)),
                bottom: TabBar(
                    labelColor: Colors.white,
                    indicatorColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Colors.white70,
                    labelStyle: primaryTextStyle(size: 14),
                    tabs: [
                      Tab(text: TranslationConstants.orders.t(context)),
                      Tab(
                          text:
                              TranslationConstants.suggestCustomers.t(context)),
                    ]),
                actions: [
                  IconButton(
                      onPressed: () async {
                        var isAdded = await Navigator.of(context).pushNamed(
                          RouteList.addOrderScreen,
                        );
                        if (isAdded == true) {
                          orderViewModel.getOrders();
                        }
                      },
                      icon: Icon(Icons.add_circle_outline)),
                  SizedBox(width: 15),
                ],
              ),
              body: TabBarView(
                children: [
                  OrderTransactionsWidget(),
                  CustomerSuggestionsWidget(),
                ],
              ),
            )));
  }
}
