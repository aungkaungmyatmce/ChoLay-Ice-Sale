import 'package:cholay_ice_sale/screens/target/widgets/custom_indicator.dart';
import 'package:cholay_ice_sale/screens/target/widgets/routes_widget.dart';
import 'package:cholay_ice_sale/screens/target/target_viewmodel.dart';
import 'package:cholay_ice_sale/screens/target/widgets/targets_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';

import '../../commom/constants/decoration.dart';
import '../../commom/constants/style.dart';
import '../../commom/themes/app_color.dart';

class TargetView extends StatelessWidget {
  const TargetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final targetViewModel = Provider.of<TargetViewModel>(context);
    return SafeArea(
        child: DefaultTabController(
      length: 2,
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
                    'Transactions',
                    style: boldTextStyle(size: 16, color: Colors.white),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      showMonthPicker(
                        context: context,
                        firstDate: DateTime(DateTime.now().year - 1, 5),
                        lastDate: DateTime(DateTime.now().year + 1, 9),
                        initialDate: targetViewModel.selectedMonth,
                      ).then((date) {
                        if (date != null) {
                          targetViewModel.changeMonth(date);
                        }
                      });
                    },
                    child: Align(
                      child: Container(
                        height: 38,
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
                                  .format(targetViewModel.selectedMonth),
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
                        //targetViewModel.navigate(context);
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
                        labelColor: AppColor.primaryColor,
                        indicatorColor: Colors.lightBlueAccent,
                        indicatorSize: TabBarIndicatorSize.label,
                        unselectedLabelColor: Colors.grey,
                        labelStyle: primaryTextStyle(size: 14),
                        tabs: const [
                          Tab(text: 'Targets'),
                          Tab(text: 'Routes'),
                        ]),
                    Expanded(
                      child: TabBarView(children: [
                        TargetsWidget(),
                        RoutesWidget(),
                      ]),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
