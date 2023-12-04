import 'package:cholay_ice_sale/common/constants/translation_constants.dart';
import 'package:cholay_ice_sale/common/extensions/string_extensions.dart';
import 'package:cholay_ice_sale/common/themes/app_color.dart';
import 'package:cholay_ice_sale/screens/expense_transactions/expense_transactions_screen.dart';
import 'package:cholay_ice_sale/screens/transactions/transactions_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';
import '../../common/constants/decoration.dart';
import '../../common/constants/route_constants.dart';
import '../../common/constants/style.dart';
import '../sale_transactions/sale_transactions_screen.dart';

class TransactionsView extends StatefulWidget {
  const TransactionsView({Key? key}) : super(key: key);

  @override
  State<TransactionsView> createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    final saleViewModel =
        Provider.of<TransactionsViewModel>(context, listen: false);
    saleViewModel.tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final transactionViewModel = Provider.of<TransactionsViewModel>(context);

    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  TranslationConstants.transactions.t(context),
                  style: boldTextStyle(size: 16, color: Colors.white),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    showMonthPicker(
                      context: context,
                      firstDate: DateTime(DateTime.now().year - 1, 5),
                      lastDate: DateTime(DateTime.now().year + 1, 9),
                      initialDate: transactionViewModel.selectedMonth,
                      locale: Locale('en', 'US'),
                    ).then((date) {
                      if (date != null) {
                        transactionViewModel.changeMonth(date);
                      }
                    });
                  },
                  child: Align(
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.all(10),
                      //decoration: boxDecoration(radius: 8, showShadow: true),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.white.withOpacity(0.8)),
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Text(
                            DateFormat.yMMM()
                                .format(transactionViewModel.selectedMonth),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.date_range,
                            color: Colors.white,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      transactionViewModel.navigate(context);
                    },
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: boxDecorationWithRoundedCorners(
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(30))),
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  TabBar(
                      controller: transactionViewModel.tabController,
                      labelColor: AppColor.primaryColor,
                      indicatorColor: Colors.lightBlueAccent,
                      indicatorSize: TabBarIndicatorSize.label,
                      unselectedLabelColor: Colors.grey,
                      labelStyle: primaryTextStyle(size: 14),
                      tabs: [
                        Tab(text: TranslationConstants.sales.t(context)),
                        Tab(text: TranslationConstants.expense.t(context)),
                      ]),
                  Expanded(
                    child: TabBarView(
                        controller: transactionViewModel.tabController,
                        children: [
                          SaleTransactionsScreen(),
                          ExpenseTransactionsScreen(),
                        ]),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
