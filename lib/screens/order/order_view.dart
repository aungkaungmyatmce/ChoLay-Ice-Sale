import 'package:cholay_ice_sale/screens/order/customer_suggestions_widget.dart';
import 'package:cholay_ice_sale/screens/order/order_transactions_widget.dart';
import 'package:cholay_ice_sale/screens/order/order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../commom/constants/route_constants.dart';
import '../../commom/constants/style.dart';
import '../../commom/themes/app_color.dart';

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
                title: Text('Orders'),
                bottom: TabBar(
                    labelColor: Colors.white,
                    indicatorColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.label,
                    unselectedLabelColor: Colors.white70,
                    labelStyle: primaryTextStyle(size: 14),
                    tabs: const [
                      Tab(text: 'Orders'),
                      Tab(text: 'Shops'),
                    ]),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          RouteList.addOrderScreen,
                        );
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
