import 'package:cholay_ice_sale/commom/constants/style.dart';
import 'package:cholay_ice_sale/commom/themes/app_color.dart';
import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  final int currentLevel;
  final List<int> targetLevels;

  CustomProgressIndicator(
      {required this.currentLevel, required this.targetLevels});

  @override
  Widget build(BuildContext context) {
    double progress = (currentLevel / targetLevels.last).clamp(0.0, 1.0);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            double availableWidth = constraints.maxWidth;

            return Container(
              height: 85,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: LinearProgressIndicator(
                      minHeight: 10,
                      value: progress,
                      borderRadius: BorderRadius.circular(3),
                      backgroundColor: Colors.grey[400],
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
                    ),
                  ),
                  for (int i = 0; i < targetLevels.length; i++)
                    Positioned(
                      top: 0,
                      left: ((targetLevels[i] / targetLevels.last) *
                              (availableWidth - 30)) +
                          7,
                      child: Column(
                        children: [
                          Text(
                            targetLevels[i].toString(),
                            style: secondaryTextStyle(
                              size: 11,
                              color: currentLevel >= targetLevels[i]
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                          Icon(
                            Icons.outlined_flag,
                            size: 20,
                            color: currentLevel >= targetLevels[i]
                                ? Colors.green
                                : Colors.grey,
                          ),
                        ],
                      ),
                    ),

                  Positioned(
                    top: 45,
                    left: ((currentLevel / targetLevels.last) *
                            (availableWidth - 30)) +
                        3,
                    child: Column(
                      children: [
                        Icon(
                          Icons.arrow_downward,
                          size: 20,
                          color: AppColor.secondaryColor,
                        ),
                        Text(
                          currentLevel.toString(),
                          style: secondaryTextStyle(
                              size: 11, color: AppColor.secondaryColor),
                        ),
                      ],
                    ),
                  ),

                  // Positioned(
                  //   left: (500 / targetLevel3) * availableWidth,
                  //   child: Container(
                  //     width: 30.0,
                  //     height: 30.0,
                  //     decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: Colors.blue,
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         '500',
                  //         style: TextStyle(
                  //           color: AppColor.secondaryColor,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
