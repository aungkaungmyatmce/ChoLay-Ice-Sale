import 'package:cholay_ice_sale/commom/themes/app_color.dart';
import 'package:cholay_ice_sale/screens/add_transaction/add_expense_screen.dart';
import 'package:cholay_ice_sale/screens/add_transaction/add_sale_screen.dart';
import 'package:cholay_ice_sale/screens/add_transaction/add_transaction_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../commom/constants/decoration.dart';
import '../../commom/constants/style.dart';

class AddTransactionView extends StatefulWidget {
  const AddTransactionView({Key? key}) : super(key: key);

  @override
  State<AddTransactionView> createState() => _AddTransactionViewState();
}

class _AddTransactionViewState extends State<AddTransactionView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addTransactionViewModel =
        Provider.of<AddTransactionViewModel>(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 3, left: 5, right: 5),
        decoration: boxDecorationWithRoundedCorners(
            borderRadius:
                const BorderRadius.only(topRight: Radius.circular(30))),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios_rounded)),
                Text(
                  'AddNewTransaction',
                  style: boldTextStyle(size: 16, color: Colors.black),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => addTransactionViewModel.datePick(context),
                  child: Align(
                    child: Container(
                      height: 38,
                      padding: const EdgeInsets.all(10),
                      //decoration: boxDecoration(radius: 8, showShadow: true),
                      // decoration: boxDecorationRoundedWithShadow(20
                      //     // backgroundColor: Colors.grey.shade100,
                      //     // borderRadius: BorderRadius.only(
                      //     //     topRight: Radius.circular(15),
                      //     //     bottomLeft: Radius.circular(15)),
                      //     ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        //color: Colors.grey.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Text(
                            DateFormat.yMMMd()
                                .format(addTransactionViewModel.selectedDate),
                            style: const TextStyle(
                                color: Colors.black87, fontSize: 14),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.date_range,
                            color: AppColor.primaryColor,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
            TabBar(
                controller: tabController,
                labelColor: AppColor.primaryColor,
                indicatorColor: Colors.lightBlueAccent,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: Colors.grey,
                labelStyle: primaryTextStyle(size: 14),
                tabs: const [
                  Tab(text: 'Income'),
                  Tab(text: 'Expense'),
                ]),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: TabBarView(controller: tabController, children: [
                  AddSaleScreen(),
                  AddExpenseScreen(),
                ]),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
