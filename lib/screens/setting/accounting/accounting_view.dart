import 'package:cholay_ice_sale/common/extensions/string_extensions.dart';
import 'package:cholay_ice_sale/common/themes/app_color.dart';
import 'package:cholay_ice_sale/screens/setting/accounting/accounting_viewmodel.dart';
import 'package:cholay_ice_sale/widgets/body_widget.dart';
import 'package:cholay_ice_sale/widgets/drawSaleExpTable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/style.dart';
import '../../../widgets/draw_table.dart';

class AccountingView extends StatelessWidget {
  const AccountingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AccountingViewModel accountingViewModel =
        Provider.of<AccountingViewModel>(context);
    List<Map<String, dynamic>> tableDataList =
        accountingViewModel.saleTransactionsForOneMonth();
    List<Map<String, dynamic>> totalSaleAndExpenseDaily =
        accountingViewModel.totalSaleAndExpenseDaily();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Accounting'),
        actions: [
          InkWell(
            onTap: () {
              showMonthPicker(
                context: context,
                firstDate: DateTime(DateTime.now().year - 1, 5),
                lastDate: DateTime(DateTime.now().year + 1, 9),
                initialDate: accountingViewModel.selectedMonth,
                locale: Locale('en', 'US'),
              ).then((date) {
                if (date != null) {
                  accountingViewModel.changeMonth(date);
                }
              });
            },
            child: Align(
              child: Container(
                height: 40,
                padding: const EdgeInsets.all(10),
                //decoration: boxDecoration(radius: 8, showShadow: true),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(0.8)),
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Text(
                      DateFormat.yMMM()
                          .format(accountingViewModel.selectedMonth!),
                      style: const TextStyle(color: Colors.white, fontSize: 14),
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
          SizedBox(width: 15)
        ],
      ),
      body: BodyWidget(
        appError: accountingViewModel.appError,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (totalSaleAndExpenseDaily.isNotEmpty &&
                        totalSaleAndExpenseDaily.last['date'] ==
                            DateFormat('dd MMM')
                                .format(DateTime.now())
                                .toString())
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Text('Today', style: secondaryTextStyle(size: 16)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Sale', style: secondaryTextStyle()),
                                Text(
                                    totalSaleAndExpenseDaily.last['totalSale']
                                        .toString()
                                        .formatWithCommas(),
                                    style:
                                        secondaryTextStyle(color: Colors.green))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Expense', style: secondaryTextStyle()),
                                Text(
                                    totalSaleAndExpenseDaily
                                        .last['totalExpense']
                                        .toString()
                                        .formatWithCommas(),
                                    style:
                                        secondaryTextStyle(color: Colors.red))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('NetProfit', style: secondaryTextStyle()),
                                Text(
                                    totalSaleAndExpenseDaily.last['netIncome']
                                        .toString()
                                        .formatWithCommas(),
                                    style: secondaryTextStyle())
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),

                    Text('The whole month',
                        style: secondaryTextStyle(size: 16)),
                    SizedBox(height: 10),

                    if (tableDataList.isNotEmpty)
                      DrawTable(tableDataList: tableDataList),

                    ///
                    if (tableDataList.isNotEmpty)
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Divider(
                            indent: 1,
                            thickness: 1,
                          ),
                        ),
                      ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.23,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Sales',
                                  style: boldTextStyle(size: 15, height: 1)),
                              Text(
                                  accountingViewModel
                                          .totalSaleAndExpense()['totalSale']
                                          .toString()
                                          .formatWithCommas() +
                                      '  ',
                                  textAlign: TextAlign.end,
                                  style: boldTextStyle(
                                      color: Colors.green, size: 15)),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Expense',
                                  style: boldTextStyle(size: 15, height: 1)),
                              Text(
                                  accountingViewModel
                                          .totalSaleAndExpense()['totalExpense']
                                          .toString()
                                          .formatWithCommas() +
                                      '  ',
                                  textAlign: TextAlign.end,
                                  style: boldTextStyle(
                                      color: Colors.red, size: 15)),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Net Profit',
                                  style: boldTextStyle(size: 15, height: 1)),
                              Text(
                                  accountingViewModel
                                          .totalSaleAndExpense()['netIncome']
                                          .toString()
                                          .formatWithCommas() +
                                      '  ',
                                  textAlign: TextAlign.end,
                                  style: boldTextStyle(
                                      color: AppColor.primaryColor, size: 15)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30),

                    if (tableDataList.isNotEmpty)
                      DrawSaleExpTable(tableDataList: totalSaleAndExpenseDaily),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
