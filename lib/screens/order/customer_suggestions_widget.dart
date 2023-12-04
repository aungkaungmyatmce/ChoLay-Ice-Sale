import 'package:cholay_ice_sale/common/constants/translation_constants.dart';
import 'package:cholay_ice_sale/common/extensions/string_extensions.dart';
import 'package:cholay_ice_sale/common/themes/app_color.dart';
import 'package:cholay_ice_sale/screens/order/order_viewmodel.dart';
import 'package:cholay_ice_sale/widgets/body_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/constants/decoration.dart';
import '../../common/constants/style.dart';

class CustomerSuggestionsWidget extends StatelessWidget {
  const CustomerSuggestionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderViewModel = Provider.of<OrderViewModel>(context);
    List<Map<String, dynamic>> suggestList =
        orderViewModel.customerSuggestList();

    return BodyWidget(
      appError: orderViewModel.appError,
      child: Container(
        //margin: EdgeInsets.only(top: 90),
        decoration: boxDecorationWithRoundedCorners(
            borderRadius:
                const BorderRadius.only(topRight: Radius.circular(32))),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (suggestList.isEmpty)
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Text('No Shops to call!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.lightBlue,
                      )),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: ListView.separated(
                    itemCount: suggestList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      DateTime currentTime = DateTime.now().subtract(
                          Duration(days: suggestList[index]['last order']));
                      String curTime = DateFormat.yMMMd().format(currentTime);
                      return Container(
                        height: 105,
                        margin: const EdgeInsets.all(3),
                        padding: const EdgeInsets.all(10),
                        decoration: boxDecorationRoundedWithShadow(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                //SizedBox(width: 50),
                                Text(
                                  suggestList[index]['name'],
                                  style: secondaryTextStyle(size: 15),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () async {
                                    // String? phNo = Provider.of<AllProvider>(
                                    //     context,
                                    //     listen: false)
                                    //     .getShopPhNo(shopList[index]['name']);
                                    //
                                    // String url = 'tel:' + phNo.toString();
                                    // if (await canLaunch(url)) {
                                    //   await launch(url);
                                    // } else {
                                    //   throw 'Could not launch $url';
                                    // }
                                  },
                                  child: const Icon(
                                    Icons.phone,
                                    color: Colors.green,
                                  ),
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                            SizedBox(height: 5),

                            Row(
                              children: [
                                Text(
                                  '${TranslationConstants.lastOrder.t(context)} :',
                                  style: secondaryTextStyle(),
                                ),
                                Spacer(),
                                Text(
                                    suggestList[index]['last order'] == 1
                                        ? TranslationConstants.yesterday
                                            .t(context)
                                        : '${suggestList[index]['last order']}'
                                            .tLastOrder(context),
                                    style: secondaryTextStyle()),
                                if (suggestList[index]['last order'] != 1)
                                  Text(' ($curTime)',
                                      style: secondaryTextStyle()),
                              ],
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${TranslationConstants.orderHabit.t(context)} : ',
                                  style: secondaryTextStyle(),
                                ),
                                Text(
                                  suggestList[index]['order habit'] == 1
                                      ? TranslationConstants.everyday.t(context)
                                      : '${suggestList[index]['order habit']}'
                                          .tOrderHabit(context),
                                  style: secondaryTextStyle(),
                                ),
                              ],
                            ),
                            //SizedBox(height: 3),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
