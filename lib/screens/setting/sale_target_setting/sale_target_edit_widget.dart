import 'package:cholay_ice_sale/common/constants/style.dart';
import 'package:cholay_ice_sale/core/models/app_error.dart';
import 'package:cholay_ice_sale/screens/setting/sale_target_setting/sale_target_setting_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/decoration.dart';
import '../../../common/themes/app_color.dart';
import '../../../core/models/targets/sale_target.dart';

class SaleTargetEditWidget extends StatefulWidget {
  final SaleTarget saleTarget;
  final SaleTargetSettingViewModel saleTargetSettingViewModel;
  const SaleTargetEditWidget(
      {Key? key,
      required this.saleTarget,
      required this.saleTargetSettingViewModel})
      : super(key: key);

  @override
  State<SaleTargetEditWidget> createState() => _SaleTargetEditWidgetState();
}

class _SaleTargetEditWidgetState extends State<SaleTargetEditWidget> {
  List<TextEditingController> amountController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  List<TextEditingController> awardController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  bool isLoading = false;

  Future<void> save() async {
    if (amountController[0].text.isEmpty) {
      return;
    } else if (amountController[2].text.isNotEmpty &&
        amountController[1].text.isEmpty) {
      return;
    }
    List<TargetInfo> targetInfoList = [];
    for (int index = 0; index < amountController.length; index++) {
      if (amountController[index].text.isNotEmpty) {
        targetInfoList.add(
          TargetInfo(
              amount: int.parse(amountController[index].text),
              level: index + 1,
              pricePool: awardController[index].text),
        );
      }
    }
    setState(() {
      isLoading = true;
    });
    SaleTarget target = SaleTarget(
        productName: widget.saleTarget.productName, targets: targetInfoList);
    await widget.saleTargetSettingViewModel.updateTargetList(target);
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop(true);
  }

  @override
  void initState() {
    for (int index = 0; index < widget.saleTarget.targets.length; index++) {
      if (widget.saleTarget.targets[index].amount != 0) {
        amountController[index].text =
            widget.saleTarget.targets[index].amount.toString();
      }
      if (widget.saleTarget.targets[index].pricePool != null) {
        awardController[index].text =
            widget.saleTarget.targets[index].pricePool.toString();
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Target Edit'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(widget.saleTarget.productName, style: secondaryTextStyle()),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Level 1 :    ', style: secondaryTextStyle()),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: amountController[0],
                            keyboardType: TextInputType.number,
                            style: secondaryTextStyle(),
                            decoration: const InputDecoration(
                              hintText: 'Amount',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            controller: awardController[0],
                            style: secondaryTextStyle(),
                            decoration: const InputDecoration(
                              hintText: 'Reward',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Level 2 :    ', style: secondaryTextStyle()),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: amountController[1],
                            keyboardType: TextInputType.number,
                            style: secondaryTextStyle(),
                            decoration: const InputDecoration(
                              hintText: 'Amount',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            controller: awardController[1],
                            style: secondaryTextStyle(),
                            decoration: const InputDecoration(
                              hintText: 'Reward',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Level 3 :    ', style: secondaryTextStyle()),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: amountController[2],
                            keyboardType: TextInputType.number,
                            style: secondaryTextStyle(),
                            decoration: const InputDecoration(
                              hintText: 'Amount',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            controller: awardController[2],
                            style: secondaryTextStyle(),
                            decoration: const InputDecoration(
                              hintText: 'Reward',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  save();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 2.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust the radius as needed
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
