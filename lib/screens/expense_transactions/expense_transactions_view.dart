import 'package:cholay_ice_sale/screens/expense_transactions/expense_transactions_viewmodel.dart';
import 'package:cholay_ice_sale/widgets/body_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants/decoration.dart';
import '../../common/constants/style.dart';
import '../../core/services/confirm_delete_tran.dart';

class ExpenseTransactionsView extends StatelessWidget {
  const ExpenseTransactionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expTranViewModel = Provider.of<ExpenseTransactionsViewModel>(context);
    List<Map<String, dynamic>> dailyTranList =
        expTranViewModel.expenseTransactionsForOneMonth();

    return BodyWidget(
      appError: expTranViewModel.appError,
      emptyText: 'No Transactions for this month!',
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.only(top: 5, bottom: 8),
          child: Column(
            children: [
              /// Data List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: dailyTranList.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: boxDecorationRoundedWithShadow(12),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(dailyTranList[index]['date'],
                                  style:
                                      boldTextStyle(weight: FontWeight.w600)),
                              Text(
                                dailyTranList[index]['totalSum'].toString(),
                                style: secondaryTextStyle(
                                    color: Colors.green, size: 15),
                              ),
                            ],
                          ),
                          const Divider(),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: dailyTranList[index]['tranList'].length,
                            itemBuilder: (context, index2) {
                              return Dismissible(
                                key: UniqueKey(),
                                confirmDismiss: (direction) {
                                  return confirmDeleteTran(context);
                                },
                                onDismissed: (direction) async {
                                  await expTranViewModel.deleteExpenseTran(
                                      dailyTranList[index]['tranList'][index2]);
                                },
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Icon(Icons.delete,
                                      color: Colors.white),
                                  alignment: Alignment.centerRight,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            dailyTranList[index]['tranList']
                                                    [index2]
                                                .expenseName,
                                            overflow: TextOverflow.ellipsis,
                                            style: secondaryTextStyle(size: 15),
                                          ),
                                          if (dailyTranList[index]['tranList']
                                                      [index2]
                                                  .note !=
                                              null)
                                            Text(
                                              dailyTranList[index]['tranList']
                                                          [index2]
                                                      .note ??
                                                  '',
                                              style: secondaryTextStyle(
                                                  weight: FontWeight.w500,
                                                  size: 14),
                                            )
                                        ],
                                      ),
                                      Text(
                                        dailyTranList[index]['tranList'][index2]
                                            .amount
                                            .toString(),
                                        style: secondaryTextStyle(),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
