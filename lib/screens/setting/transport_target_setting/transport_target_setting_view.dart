import 'package:cholay_ice_sale/common/extensions/string_extensions.dart';
import 'package:cholay_ice_sale/screens/setting/transport_target_setting/transport_target_edit_widget.dart';
import 'package:cholay_ice_sale/screens/setting/transport_target_setting/transport_target_setting_viewmodel.dart';
import 'package:cholay_ice_sale/widgets/body_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../common/constants/decoration.dart';
import '../../../common/constants/style.dart';
import '../../../common/themes/app_color.dart';
import '../../../core/services/confirm_delete_tran.dart';

class TransportTargetSettingView extends StatelessWidget {
  const TransportTargetSettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransportTargetSettingViewModel targetSettingViewModel =
        Provider.of<TransportTargetSettingViewModel>(context);
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
              Container(
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
                          'Transport Target',
                          style: secondaryTextStyle(
                              size: 14, color: AppColor.primaryColor),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () async {
                              var isEdited = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TransportTargetEditWidget(
                                              transportTargetList:
                                                  targetSettingViewModel
                                                      .transportTargetList,
                                              transportTargetSettingViewModel:
                                                  targetSettingViewModel)));
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
                      itemCount:
                          targetSettingViewModel.transportTargetList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Row(
                                      children: [
                                        Text(
                                            'Level  ${targetSettingViewModel.transportTargetList[index].targetLevel.toString()}   ',
                                            style: secondaryTextStyle()),
                                        Text(
                                            '${DateFormat('hh:mm').format(targetSettingViewModel.transportTargetList[index].startingTime)}AM  '
                                            '${targetSettingViewModel.transportTargetList[index].days.toString()} days',
                                            style: secondaryTextStyle()),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      flex: 5,
                                      child: Row(
                                        children: [
                                          if (targetSettingViewModel
                                                  .transportTargetList[index]
                                                  .pricePool !=
                                              null)
                                            Text('  Award  ',
                                                style: secondaryTextStyle()),
                                          if (targetSettingViewModel
                                                  .transportTargetList[index]
                                                  .pricePool !=
                                              null)
                                            Expanded(
                                              child: Text(
                                                targetSettingViewModel
                                                    .transportTargetList[index]
                                                    .pricePool!
                                                    .intelliTrim(),
                                                style: secondaryTextStyle(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                        ],
                                      )),
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
        ),
      ),
    );
  }
}
