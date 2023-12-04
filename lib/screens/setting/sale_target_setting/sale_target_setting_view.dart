import 'package:cholay_ice_sale/core/models/app_error.dart';
import 'package:cholay_ice_sale/screens/setting/sale_target_setting/sale_target_edit_widget.dart';
import 'package:cholay_ice_sale/screens/setting/sale_target_setting/sale_target_setting_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/decoration.dart';
import '../../../common/constants/style.dart';
import '../../../common/themes/app_color.dart';
import '../../../core/services/confirm_delete_tran.dart';
import '../../../widgets/body_widget.dart';
import '../transport_target_setting/transport_target_setting_viewmodel.dart';

class SaleTargetSettingView extends StatelessWidget {
  const SaleTargetSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SaleTargetSettingViewModel targetSettingViewModel =
        Provider.of<SaleTargetSettingViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Targets'),
      ),
      body: BodyWidget(
        appError: targetSettingViewModel.appError,
        emptyText: 'No Targets added!',
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 5),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: targetSettingViewModel.saleTargetList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                    child: Container(
                      //margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: boxDecorationRoundedWithShadow(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                targetSettingViewModel
                                    .saleTargetList[index].productName,
                                style: secondaryTextStyle(
                                    size: 14, color: AppColor.primaryColor),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () async {
                                    var isEdited = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SaleTargetEditWidget(
                                                  saleTarget:
                                                      targetSettingViewModel
                                                              .saleTargetList[
                                                          index],
                                                  saleTargetSettingViewModel:
                                                      targetSettingViewModel),
                                        ));
                                    if (isEdited == true) {
                                      targetSettingViewModel.getData();
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  )),
                            ],
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: targetSettingViewModel
                                .saleTargetList[index].targets.length,
                            itemBuilder: (context, index2) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              'Level  ${targetSettingViewModel.saleTargetList[index].targets[index2].level.toString()}  ',
                                              style: secondaryTextStyle()),
                                          Text(
                                              targetSettingViewModel
                                                  .saleTargetList[index]
                                                  .targets[index2]
                                                  .amount
                                                  .toString(),
                                              style: secondaryTextStyle()),
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
                                          if (targetSettingViewModel
                                                  .saleTargetList[index]
                                                  .targets[index2]
                                                  .pricePool !=
                                              null)
                                            Text('Award  ',
                                                style: secondaryTextStyle()),
                                          if (targetSettingViewModel
                                                  .saleTargetList[index]
                                                  .targets[index2]
                                                  .pricePool !=
                                              null)
                                            Text(
                                                '${targetSettingViewModel.saleTargetList[index].targets[index2].pricePool.toString()} ks',
                                                style: secondaryTextStyle()),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
