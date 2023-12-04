import 'package:cholay_ice_sale/common/constants/translation_constants.dart';
import 'package:cholay_ice_sale/common/extensions/string_extensions.dart';
import 'package:cholay_ice_sale/common/themes/app_color.dart';
import 'package:cholay_ice_sale/core/services/printer_service.dart';
import 'package:cholay_ice_sale/core/services/ui_helper.dart';
import 'package:cholay_ice_sale/screens/printer/sale_print_viewmodel.dart';
import 'package:cholay_ice_sale/widgets/product_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../common/constants/decoration.dart';
import '../../common/constants/style.dart';
import '../../widgets/connect_printer.dart';

class SalePrintView extends StatelessWidget {
  const SalePrintView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final salePrintViewModel = Provider.of<SalePrintViewModel>(context);
    salePrintViewModel.printerService =
        Provider.of<PrinterService>(context, listen: false);
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColor.primaryColor,
            body: Container(
              padding:
                  const EdgeInsets.only(top: 10, bottom: 3, left: 5, right: 5),
              decoration: boxDecorationWithRoundedCorners(
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(30))),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_rounded,
                              color: AppColor.secondaryColor,
                            )),
                        Text(
                          TranslationConstants.print.t(context),
                          style: boldTextStyle(
                              size: 16, color: AppColor.secondaryColor),
                        ),
                        const Spacer(),
                        Consumer<PrinterService>(builder: (_, controller, __) {
                          return IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    return const SizedBox(
                                      height: 500,
                                      child: ConnectPrinter(),
                                    );
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.print,
                                color: controller.connected
                                    ? Colors.green
                                    : Colors.black54,
                              ));
                        }),
                        const SizedBox(width: 20),
                        Text(
                          TranslationConstants.addToSales.t(context),
                          style: boldTextStyle(
                              size: 14, color: AppColor.secondaryColor),
                        ),
                        Switch(
                          value: salePrintViewModel.isSaveData,
                          thumbColor: MaterialStateProperty.all<Color>(
                              AppColor.primaryColor),
                          onChanged: (value) {
                            salePrintViewModel.changeSave();
                          },
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    Divider(thickness: 1),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(bottom: 5),
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 14, left: 5, right: 5),
                      // decoration: boxDecorationWithRoundedCorners(
                      //   backgroundColor: Colors.grey.shade100,
                      //   borderRadius: BorderRadius.circular(12),
                      // ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Stack(
                                  children: [
                                    SizedBox(
                                      width: 180,
                                      height: 50,
                                      child: TextField(
                                        controller: salePrintViewModel
                                            .customerNameController,
                                        style: boldTextStyle(
                                            color: AppColor.secondaryColor,
                                            size: 16),
                                        decoration: InputDecoration(
                                          hintText: TranslationConstants
                                              .shopName
                                              .t(context),
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        right: 0,
                                        top: 1,
                                        child: PopupMenuButton(
                                          icon: const Icon(
                                            Icons.expand_more,
                                          ),
                                          itemBuilder: (context) =>
                                              salePrintViewModel.customerList
                                                  .map((customer) =>
                                                      PopupMenuItem(
                                                        child: Text(
                                                          customer.name,
                                                          style:
                                                              secondaryTextStyle(),
                                                        ),
                                                        value: customer.name,
                                                      ))
                                                  .toList(),
                                          onSelected: (String text) {
                                            salePrintViewModel
                                                .selectCustomer(text);
                                          },
                                        )),
                                  ],
                                ),
                              ),
                              // InkWell(
                              //   onTap: () {},
                              //   child: Align(
                              //     child: Container(
                              //       height: 38,
                              //       padding: const EdgeInsets.all(10),
                              //       //decoration: boxDecoration(radius: 8, showShadow: true),
                              //       // decoration: boxDecorationRoundedWithShadow(20
                              //       //     // backgroundColor: Colors.grey.shade100,
                              //       //     // borderRadius: BorderRadius.only(
                              //       //     //     topRight: Radius.circular(15),
                              //       //     //     bottomLeft: Radius.circular(15)),
                              //       //     ),
                              //       // decoration: BoxDecoration(
                              //       //   border: Border.all(color: Colors.black12),
                              //       //   //color: Colors.grey.withOpacity(0.8),
                              //       //   borderRadius: BorderRadius.circular(5),
                              //       // ),
                              //       child: Row(
                              //         children: [
                              //           Text(
                              //             DateFormat.yMMMd()
                              //                 .format(DateTime.now()),
                              //             style: secondaryTextStyle(),
                              //           ),
                              //           const SizedBox(width: 8),
                              //           const Icon(
                              //             Icons.date_range,
                              //             color: AppColor.primaryColor,
                              //             size: 15,
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              TextButton.icon(
                                onPressed: () {
                                  salePrintViewModel.datePick(context);
                                },
                                icon: const Icon(
                                  Icons.date_range,
                                  color: AppColor.primaryColor,
                                ),
                                label: Text(
                                  DateFormat.yMMMd()
                                      .format(salePrintViewModel.selectedDate),
                                  style: secondaryTextStyle(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          for (int i = 0; i <= salePrintViewModel.tranNum; i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ProductInfoWidget(
                                productNameController:
                                    salePrintViewModel.productNameController[i],
                                amountController:
                                    salePrintViewModel.quantityController[i],
                                priceController:
                                    salePrintViewModel.priceController[i],
                                totalController:
                                    salePrintViewModel.totalController[i],
                              ),
                            ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (salePrintViewModel.tranNum < 4)
                                IconButton(
                                    onPressed: () {
                                      salePrintViewModel
                                          .addProductTransaction();
                                    },
                                    icon: Icon(Icons.add)),
                              if (salePrintViewModel.tranNum > 0)
                                IconButton(
                                    onPressed: () {
                                      salePrintViewModel
                                          .removeProductTransaction();
                                    },
                                    icon: Icon(Icons.remove)),
                            ],
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: salePrintViewModel.isLoading
                                ? () {}
                                : () {
                                    if (!salePrintViewModel
                                        .printerService.connected) {
                                      UIHelper.showSuccessFlushBar(
                                          context,
                                          TranslationConstants.connectThePrinter
                                              .t(context),
                                          icon: Icons.print_outlined,
                                          color: Colors.red);
                                    } else {
                                      salePrintViewModel.saveAndPrint(context);
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryColor,
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 2.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Adjust the radius as needed
                              ),
                            ),
                            child: salePrintViewModel.isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  )
                                : Text(
                                    'Print',
                                  ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
