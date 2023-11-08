import 'package:cholay_ice_sale/screens/add_order/add_order_viewmodel.dart';
import 'package:cholay_ice_sale/widgets/order_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../commom/constants/decoration.dart';
import '../../commom/constants/style.dart';
import '../../commom/themes/app_color.dart';
import '../../widgets/product_info_widget.dart';

class AddOrderView extends StatelessWidget {
  const AddOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addOrderViewModel = Provider.of<AddOrderViewModel>(context);

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
                          'Add Order',
                          style: boldTextStyle(
                              size: 16, color: AppColor.secondaryColor),
                        ),
                        const Spacer(),
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
                                        controller: addOrderViewModel
                                            .customerNameController,
                                        style: boldTextStyle(
                                            color: AppColor.secondaryColor,
                                            size: 16),
                                        decoration: const InputDecoration(
                                          hintText: 'Shop Name',
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
                                              addOrderViewModel.customerList
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
                                            addOrderViewModel
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
                                  addOrderViewModel.datePick(context);
                                },
                                icon: const Icon(
                                  Icons.date_range,
                                  color: AppColor.primaryColor,
                                ),
                                label: Text(
                                  DateFormat.yMMMd()
                                      .format(addOrderViewModel.selectedDate),
                                  style: secondaryTextStyle(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          for (int i = 0; i <= addOrderViewModel.tranNum; i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: OrderInfoWidget(
                                productNameController:
                                    addOrderViewModel.productNameController[i],
                                amountController:
                                    addOrderViewModel.quantityController[i],
                                priceController:
                                    addOrderViewModel.priceController[i],
                                totalController:
                                    addOrderViewModel.totalController[i],
                              ),
                            ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (addOrderViewModel.tranNum < 2)
                                IconButton(
                                    onPressed: () {
                                      addOrderViewModel.addOrderTransaction();
                                    },
                                    icon: Icon(Icons.add)),
                              if (addOrderViewModel.tranNum > 0)
                                IconButton(
                                    onPressed: () {
                                      addOrderViewModel
                                          .removeOrderTransaction();
                                    },
                                    icon: Icon(Icons.remove)),
                            ],
                          ),
                          SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: addOrderViewModel.isLoading
                                ? () {}
                                : () {
                                    addOrderViewModel.saveOrder(context);
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
                            child: addOrderViewModel.isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                        color: Colors.white),
                                  )
                                : Text('Save'),
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
