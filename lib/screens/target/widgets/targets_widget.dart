import 'package:cholay_ice_sale/commom/themes/app_color.dart';
import 'package:cholay_ice_sale/screens/target/target_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../commom/constants/decoration.dart';
import '../../../commom/constants/style.dart';
import 'custom_indicator.dart';

class TargetsWidget extends StatelessWidget {
  const TargetsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final targetViewModel = Provider.of<TargetViewModel>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: targetViewModel.saleTargetList.length,
            itemBuilder: (context, index) {
              int? currentLevel = targetViewModel.productsSoldAmount()[
                  targetViewModel.saleTargetList[index].productName];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                child: Container(
                  //margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  //decoration: boxDecorationRoundedWithShadow(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            targetViewModel.saleTargetList[index].productName,
                            style: secondaryTextStyle(
                                size: 14, color: AppColor.primaryColor),
                          ),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: targetViewModel
                            .saleTargetList[index].targets.length,
                        itemBuilder: (context, index2) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 3),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          'Level  ${targetViewModel.saleTargetList[index].targets[index2].level.toString()}  ',
                                          style: secondaryTextStyle(
                                              color: targetViewModel
                                                              .productsSoldAmount()[
                                                          targetViewModel
                                                              .saleTargetList[
                                                                  index]
                                                              .productName]! >
                                                      targetViewModel
                                                          .saleTargetList[index]
                                                          .targets[index2]
                                                          .amount
                                                  ? Colors.green
                                                  : null)),
                                      Text(
                                          targetViewModel.saleTargetList[index]
                                              .targets[index2].amount
                                              .toString(),
                                          style: secondaryTextStyle(
                                              color: targetViewModel
                                                              .productsSoldAmount()[
                                                          targetViewModel
                                                              .saleTargetList[
                                                                  index]
                                                              .productName]! >
                                                      targetViewModel
                                                          .saleTargetList[index]
                                                          .targets[index2]
                                                          .amount
                                                  ? Colors.green
                                                  : null)),
                                    ],
                                  ),
                                ),
                                Flexible(flex: 2, child: Container()),
                                Expanded(
                                  flex: 4,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (targetViewModel.saleTargetList[index]
                                              .targets[index2].pricePool !=
                                          null)
                                        Text('Award  ',
                                            style: secondaryTextStyle(
                                                color: targetViewModel
                                                                .productsSoldAmount()[
                                                            targetViewModel
                                                                .saleTargetList[
                                                                    index]
                                                                .productName]! >
                                                        targetViewModel
                                                            .saleTargetList[
                                                                index]
                                                            .targets[index2]
                                                            .amount
                                                    ? Colors.green
                                                    : null)),
                                      if (targetViewModel.saleTargetList[index]
                                              .targets[index2].pricePool !=
                                          null)
                                        Text(
                                            '${targetViewModel.saleTargetList[index].targets[index2].pricePool.toString()} ks',
                                            style: secondaryTextStyle(
                                                color: targetViewModel
                                                                .productsSoldAmount()[
                                                            targetViewModel
                                                                .saleTargetList[
                                                                    index]
                                                                .productName]! >
                                                        targetViewModel
                                                            .saleTargetList[
                                                                index]
                                                            .targets[index2]
                                                            .amount
                                                    ? Colors.green
                                                    : null)),
                                    ],
                                  ),
                                ),
                                if (targetViewModel.productsSoldAmount()[
                                        targetViewModel.saleTargetList[index]
                                            .productName]! >
                                    targetViewModel.saleTargetList[index]
                                        .targets[index2].amount)
                                  const Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Icon(
                                      size: 25,
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                    ),
                                  )
                                else
                                  const SizedBox(width: 40)
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Current',
                                    style: secondaryTextStyle(
                                        color: AppColor.secondaryColor)),
                                Text(
                                    targetViewModel
                                        .productsSoldAmount()[targetViewModel
                                            .saleTargetList[index].productName]
                                        .toString(),
                                    style: secondaryTextStyle()),
                              ],
                            ),
                          ),
                          Flexible(flex: 7, child: Container())
                        ],
                      ),
                      CustomProgressIndicator(
                        currentLevel: currentLevel!,
                        targetLevels: targetViewModel
                            .saleTargetList[index].targets
                            .map((target) => target.amount)
                            .toList(),
                      ),
                      SizedBox(height: 15),
                      const Divider(
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Container(
            //margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            //decoration: boxDecorationRoundedWithShadow(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Transport Target',
                      style: secondaryTextStyle(
                          size: 14, color: AppColor.primaryColor),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: targetViewModel.transportTargetList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                  'Level  ${targetViewModel.transportTargetList[index].targetLevel.toString()} : ',
                                  style: secondaryTextStyle(
                                      color: targetViewModel
                                                  .transportTargetReach()[index]
                                              ['isReached']
                                          ? Colors.green
                                          : AppColor.secondaryColor)),
                              Text(
                                  '${DateFormat('hh:mm').format(targetViewModel.transportTargetList[index].startingTime)}AM  '
                                  '${targetViewModel.transportTargetList[index].days.toString()} days',
                                  style: secondaryTextStyle(
                                      color: targetViewModel
                                                  .transportTargetReach()[index]
                                              ['isReached']
                                          ? Colors.green
                                          : AppColor.secondaryColor)),
                              const Spacer(),
                              if (targetViewModel
                                      .transportTargetList[index].pricePool !=
                                  null)
                                Text('Award : ',
                                    style: secondaryTextStyle(
                                        color: targetViewModel
                                                    .transportTargetReach()[
                                                index]['isReached']
                                            ? Colors.green
                                            : AppColor.secondaryColor)),
                              if (targetViewModel
                                      .transportTargetList[index].pricePool !=
                                  null)
                                Text(
                                    '${targetViewModel.transportTargetList[index].pricePool.toString()} ks',
                                    style: secondaryTextStyle(
                                        color: targetViewModel
                                                    .transportTargetReach()[
                                                index]['isReached']
                                            ? Colors.green
                                            : AppColor.secondaryColor)),
                              // if (targetViewModel.productsSoldAmount()[
                              //         targetViewModel
                              //             .saleTargetList[index].productName]! >
                              //     targetViewModel.saleTargetList[index]
                              //         .targets[index2].amount)
                              //   const Padding(
                              //     padding: EdgeInsets.only(left: 15),
                              //     child: Icon(
                              //       size: 25,
                              //       Icons.check_circle_outline,
                              //       color: Colors.green,
                              //     ),
                              //   )
                              // else
                              //   const SizedBox(width: 40)
                            ],
                          ),
                          CustomProgressIndicator(
                            currentLevel: targetViewModel
                                .transportTargetReach()[index]['reachDays']!,
                            targetLevels: [
                              targetViewModel.transportTargetReach()[index]
                                  ['targetDays']
                            ],
                          ),
                          SizedBox(height: 15)
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}
