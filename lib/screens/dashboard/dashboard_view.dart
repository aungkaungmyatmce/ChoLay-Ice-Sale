import 'package:cholay_ice_sale/common/extensions/string_extensions.dart';
import 'package:cholay_ice_sale/screens/dashboard/dashboard_viewmodel.dart';
import 'package:cholay_ice_sale/screens/target/target_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:provider/provider.dart';

import '../../common/constants/decoration.dart';
import '../../common/constants/style.dart';
import '../../common/constants/translation_constants.dart';
import '../../common/themes/app_color.dart';
import '../sale_analytics/sale_analytics_screen.dart';

class DashBoardView extends StatelessWidget {
  const DashBoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashBoardViewModel dashBoardViewModel =
        Provider.of<DashBoardViewModel>(context);
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
                    TranslationConstants.dashBoard.t(context),
                    style: boldTextStyle(size: 16, color: Colors.white),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      showMonthPicker(
                        context: context,
                        firstDate: DateTime(DateTime.now().year - 1, 5),
                        lastDate: DateTime(DateTime.now().year + 1, 9),
                        initialDate: dashBoardViewModel.selectedMonth,
                        locale: Locale('en', 'US'),
                      ).then((date) {
                        if (date != null) {
                          dashBoardViewModel.changeMonth(date);
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
                                  .format(dashBoardViewModel.selectedMonth),
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
                  const SizedBox(width: 10),
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
                        tabs: [
                          Tab(
                              text: TranslationConstants.saleAnalytics
                                  .t(context)),
                          Tab(text: TranslationConstants.targets.t(context)),
                        ]),
                    Expanded(
                      child: TabBarView(children: [
                        SaleAnalyticsScreen(),
                        TargetScreen(),
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
