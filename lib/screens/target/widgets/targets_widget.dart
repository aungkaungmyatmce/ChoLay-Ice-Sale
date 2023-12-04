import 'package:cholay_ice_sale/common/constants/translation_constants.dart';
import 'package:cholay_ice_sale/common/extensions/string_extensions.dart';
import 'package:cholay_ice_sale/common/themes/app_color.dart';
import 'package:cholay_ice_sale/screens/target/target_viewmodel.dart';
import 'package:cholay_ice_sale/widgets/body_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../common/constants/style.dart';
import 'custom_indicator.dart';

class TargetsWidget extends StatelessWidget {
  const TargetsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final targetViewModel = Provider.of<TargetViewModel>(context);
    return BodyWidget(
      appError: targetViewModel.appError,
      emptyText: 'No Targets Added!',
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: targetViewModel.saleTargetList.length,
              itemBuilder: (context, index) {
                int total = 0;
                int? currentLevel = targetViewModel.productsSoldAmount()[
                    targetViewModel.saleTargetList[index].productName];
                targetViewModel.saleTargetList[index].targets.forEach((target) {
                  total += target.amount;
                });
                if (total == 0) {
                  return Container();
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1),
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
                                            '${TranslationConstants.level.t(context)}  ${targetViewModel.saleTargetList[index].targets[index2].level.toString()}  ',
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
                                        Text(
                                            targetViewModel
                                                .saleTargetList[index]
                                                .targets[index2]
                                                .amount
                                                .toString(),
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
                                  Flexible(flex: 2, child: Container()),
                                  Expanded(
                                    flex: 4,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (targetViewModel
                                                    .saleTargetList[index]
                                                    .targets[index2]
                                                    .pricePool !=
                                                null &&
                                            targetViewModel
                                                    .saleTargetList[index]
                                                    .targets[index2]
                                                    .pricePool !=
                                                0)
                                          Text(
                                              TranslationConstants.award
                                                  .t(context),
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
                                        if (targetViewModel
                                                    .saleTargetList[index]
                                                    .targets[index2]
                                                    .pricePool !=
                                                null &&
                                            targetViewModel
                                                    .saleTargetList[index]
                                                    .targets[index2]
                                                    .pricePool !=
                                                0)
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
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(TranslationConstants.current.t(context),
                                      style: secondaryTextStyle(
                                          color: AppColor.secondaryColor)),
                                  Text(
                                      targetViewModel
                                          .productsSoldAmount()[targetViewModel
                                              .saleTargetList[index]
                                              .productName]
                                          .toString(),
                                      style: secondaryTextStyle(
                                          color: AppColor.primaryColor)),
                                ],
                              ),
                            ),
                            Flexible(flex: 7, child: Container())
                          ],
                        ),
                        SizedBox(height: 5),
                        CustomProgressIndicator(
                          currentLevel: currentLevel!,
                          targetLevels: targetViewModel
                              .saleTargetList[index].targets
                              .map((target) => target.amount)
                              .toList(),
                          label: 'ထုပ်',
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
                  if (targetViewModel.transportTargetList.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          TranslationConstants.transportTargets.t(context),
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
                                    '${TranslationConstants.level.t(context)}  ${targetViewModel.transportTargetList[index].targetLevel.toString()}    ',
                                    style: secondaryTextStyle(
                                        color: targetViewModel
                                                    .transportTargetReach()[
                                                index]['isReached']
                                            ? Colors.green
                                            : AppColor.secondaryColor)),
                                Text(
                                    '${DateFormat('hh:mm').format(targetViewModel.transportTargetList[index].startingTime)}AM  '
                                    '${targetViewModel.transportTargetList[index].days.toString()} ${TranslationConstants.days.t(context)}',
                                    style: secondaryTextStyle(
                                        color: targetViewModel
                                                    .transportTargetReach()[
                                                index]['isReached']
                                            ? Colors.green
                                            : AppColor.secondaryColor)),
                                const Spacer(),
                                if (targetViewModel.transportTargetList[index]
                                            .pricePool !=
                                        null &&
                                    targetViewModel.transportTargetList[index]
                                            .pricePool !=
                                        0)
                                  Text('Award   ',
                                      style: secondaryTextStyle(
                                          color: targetViewModel
                                                      .transportTargetReach()[
                                                  index]['isReached']
                                              ? Colors.green
                                              : AppColor.secondaryColor)),
                                if (targetViewModel.transportTargetList[index]
                                            .pricePool !=
                                        null &&
                                    targetViewModel.transportTargetList[index]
                                            .pricePool !=
                                        0)
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
                                    ['targetDays'],
                              ],
                              label: TranslationConstants.days.t(context),
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
      ),
    );
  }
}
