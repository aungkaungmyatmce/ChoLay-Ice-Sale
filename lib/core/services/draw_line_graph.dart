import 'package:cholay_ice_sale/common/themes/app_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawLineGraph extends StatefulWidget {
  final List<int> xData;
  final List<int> yData;
  const DrawLineGraph({super.key, required this.xData, required this.yData});

  @override
  State<DrawLineGraph> createState() => _DrawLineGraphState();
}

class _DrawLineGraphState extends State<DrawLineGraph> {
  final ScrollController _horScrollController = ScrollController();

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 10))
        .then((value) => _horScrollController.animateTo(
              _horScrollController.position.maxScrollExtent,
              duration: const Duration(
                  milliseconds: 300), // You can adjust the duration as needed
              curve: Curves.easeInOut,
            ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _horScrollController,
      scrollDirection: Axis.horizontal,
      child: Column(
        children: [
          Container(
            height: 250,
            width: widget.xData.length * 50.0,
            child: LineChart(
              LineChartData(
                //gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTextStyles: (context, value) {
                      return TextStyle(
                        color: AppColor
                            .secondaryColor, // Change the title text color here
                      );
                    },
                  ),
                  bottomTitles: SideTitles(
                    getTextStyles: (context, value) {
                      return TextStyle(
                        color: AppColor
                            .secondaryColor, // Change the title text color here
                      );
                    },
                    showTitles: true,
                    getTitles: (value) {
                      if (value.toInt() >= 0 &&
                          value.toInt() < widget.xData.length) {
                        return widget.xData[value.toInt()].toString();
                      }
                      return '';
                    },
                  ),
                  rightTitles: SideTitles(
                      showTitles:
                          false), // Do not show titles on the right side
                  topTitles: SideTitles(showTitles: false),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: Colors.black26,
                    width: 1,
                  ),
                ),

                minX: 0,
                maxX: widget.xData.length.toDouble() - 1,
                minY: widget.yData
                    .reduce((value, element) => value < element
                        ? value
                        : element >= 0
                            ? element
                            : element - 20)
                    .toDouble(),
                maxY: widget.yData
                    .reduce((value, element) =>
                        value > element ? value : element + 100)
                    .toDouble(),
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(
                        widget.xData.length,
                        (index) => FlSpot(
                            index.toDouble(), widget.yData[index].toDouble())),
                    colors: [AppColor.primaryColor],
                    dotData: FlDotData(
                      show: true,
                    ),

                    //belowBarData: BarAreaData(show: false),
                  ),
                ],
                lineTouchData: LineTouchData(
                    enabled: true,
                    touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: AppColor.primaryColor,
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map(
                          (LineBarSpot touchedSpot) {
                            const textStyle = TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            );
                            return LineTooltipItem(
                              widget.yData[touchedSpot.spotIndex]
                                  .toStringAsFixed(0),
                              textStyle,
                            );
                          },
                        ).toList();
                      },
                    ),
                    getTouchedSpotIndicator:
                        (LineChartBarData barData, List<int> indicators) {
                      return indicators.map(
                        (int index) {
                          final line = FlLine(
                              color: Colors.grey,
                              strokeWidth: 1,
                              dashArray: [2, 4]);
                          return TouchedSpotIndicatorData(
                            line,
                            FlDotData(show: false),
                          );
                        },
                      ).toList();
                    },
                    getTouchLineEnd: (_, __) => double.infinity),
              ),
            ),
          ),
        ],
      ),
    );
    // body: Center(
    //   child: SingleChildScrollView(
    //     scrollDirection: Axis.horizontal,
    //     child: LineChart(
    //       LineChartData(
    //         //gridData: FlGridData(show: false),
    //         titlesData: FlTitlesData(
    //           //leftTitles: SideTitles(showTitles: true),
    //           bottomTitles: SideTitles(
    //             showTitles: true,
    //             getTitles: (value) {
    //               if (value.toInt() >= 0 && value.toInt() < xData.length) {
    //                 return xData[value.toInt()];
    //               }
    //               return '';
    //             },
    //           ),
    //         ),
    //         borderData: FlBorderData(
    //           show: true,
    //           border: Border.all(
    //             color: const Color(0xff37434d),
    //             width: 1,
    //           ),
    //         ),
    //         minX: 0,
    //         maxX: xData.length.toDouble() - 1,
    //         minY: yData.reduce(
    //             (value, element) => value < element ? value : element),
    //         maxY: yData.reduce(
    //             (value, element) => value > element ? value : element),
    //         lineBarsData: [
    //           LineChartBarData(
    //             spots: List.generate(xData.length,
    //                 (index) => FlSpot(index.toDouble(), yData[index])),
    //             colors: [Colors.blue],
    //             dotData: FlDotData(show: true),
    //             belowBarData: BarAreaData(show: false),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // ),
    ;
  }
}
