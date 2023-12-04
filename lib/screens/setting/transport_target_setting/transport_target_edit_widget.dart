import 'package:cholay_ice_sale/core/models/targets/transport_target.dart';
import 'package:cholay_ice_sale/screens/setting/transport_target_setting/transport_target_setting_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/constants/decoration.dart';
import '../../../common/constants/style.dart';
import '../../../common/themes/app_color.dart';

class TransportTargetEditWidget extends StatefulWidget {
  final List<TransportTarget> transportTargetList;
  final TransportTargetSettingViewModel transportTargetSettingViewModel;
  const TransportTargetEditWidget(
      {Key? key,
      required this.transportTargetList,
      required this.transportTargetSettingViewModel})
      : super(key: key);

  @override
  State<TransportTargetEditWidget> createState() =>
      _TransportTargetEditWidgetState();
}

class _TransportTargetEditWidgetState extends State<TransportTargetEditWidget> {
  List<TextEditingController> daysController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  List<TextEditingController> awardController = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];
  List<DateTime> timeController = [
    DateTime(2020),
    DateTime(2020),
    DateTime(2020),
  ];
  bool isLoading = false;

  Future<DateTime?> pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 00),
    );
    if (picked != null) {
      return DateTime(2024, 1, 1, picked.hour, picked.minute);
      // setState(() {
      //   bookedTime = picked1;
      // });
      // bookedDate = DateTime(bookedDate!.year, bookedDate!.month,
      //     bookedDate!.day, bookedTime!.hour, bookedTime!.minute);
    }
  }

  @override
  void initState() {
    for (int index = 0; index < widget.transportTargetList.length; index++) {
      if (widget.transportTargetList[index].days != 0) {
        daysController[index].text =
            widget.transportTargetList[index].days.toString();
      }

      if (widget.transportTargetList[index].pricePool != 0 &&
          widget.transportTargetList[index].pricePool != null) {
        awardController[index].text =
            widget.transportTargetList[index].pricePool.toString();
      }
      timeController[index] = widget.transportTargetList[index].startingTime;
    }
    super.initState();
  }

  Future<void> save() async {
    if (daysController[0].text.isEmpty || timeController[0].year == 2020) {
      return;
    } else if ((daysController[2].text.isNotEmpty ||
            timeController[2].year != 2020) &&
        (daysController[1].text.isEmpty || daysController[1].text.isEmpty)) {
      return;
    }
    List<TransportTarget> targetInfoList = [];
    for (int index = 0; index < daysController.length; index++) {
      if (daysController[index].text.isNotEmpty &&
          timeController[index].year != 2020) {
        targetInfoList.add(
          TransportTarget(
            targetLevel: index + 1,
            days: int.parse(daysController[index].text),
            startingTime: timeController[index],
            pricePool: awardController[index].text.isNotEmpty
                ? int.parse(awardController[index].text)
                : 0,
          ),
        );
      }
    }

    setState(() {
      isLoading = true;
    });

    await widget.transportTargetSettingViewModel
        .updateTargetList(targetInfoList);
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Target Edit'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text('Transport Target', style: secondaryTextStyle()),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
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
                          width: 80,
                          child: TextField(
                            controller: daysController[0],
                            keyboardType: TextInputType.number,
                            style: secondaryTextStyle(),
                            decoration: const InputDecoration(
                              hintText: 'Days',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            DateTime? date = await pickTime();
                            if (date != null) {
                              setState(() {
                                timeController[0] = date;
                              });
                            }
                          },
                          child: timeController[0].year != 2020
                              ? Text(
                                  DateFormat('hh:mm a')
                                      .format(timeController[0]),
                                  style: secondaryTextStyle(),
                                )
                              : Text('Pick Time',
                                  style:
                                      secondaryTextStyle(color: Colors.grey)),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            controller: awardController[0],
                            keyboardType: TextInputType.number,
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
                        Text(
                          'ks',
                          style: primaryTextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Level 2 :   ', style: secondaryTextStyle()),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            controller: daysController[1],
                            keyboardType: TextInputType.number,
                            style: secondaryTextStyle(),
                            decoration: const InputDecoration(
                              hintText: 'Days',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            DateTime? date = await pickTime();
                            if (date != null) {
                              setState(() {
                                timeController[1] = date;
                              });
                            }
                          },
                          child: timeController[1].year != 2020
                              ? Text(
                                  DateFormat('hh:mm a')
                                      .format(timeController[1]),
                                  style: secondaryTextStyle(),
                                )
                              : Text('Pick Time',
                                  style:
                                      secondaryTextStyle(color: Colors.grey)),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            controller: awardController[1],
                            keyboardType: TextInputType.number,
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
                        Text(
                          'ks',
                          style: primaryTextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Level 3 :   ', style: secondaryTextStyle()),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            controller: daysController[2],
                            keyboardType: TextInputType.number,
                            style: secondaryTextStyle(),
                            decoration: const InputDecoration(
                              hintText: 'Days',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            onChanged: (value) {},
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            DateTime? date = await pickTime();
                            if (date != null) {
                              setState(() {
                                timeController[2] = date;
                              });
                            }
                          },
                          child: timeController[2].year != 2020
                              ? Text(
                                  DateFormat('hh:mm a')
                                      .format(timeController[2]),
                                  style: secondaryTextStyle(),
                                )
                              : Text('Pick Time',
                                  style:
                                      secondaryTextStyle(color: Colors.grey)),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 80,
                          child: TextField(
                            controller: awardController[2],
                            keyboardType: TextInputType.number,
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
                        Text(
                          'ks',
                          style: primaryTextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
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
