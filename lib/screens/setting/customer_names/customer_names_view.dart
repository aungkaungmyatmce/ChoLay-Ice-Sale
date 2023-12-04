import 'package:cholay_ice_sale/common/extensions/string_extensions.dart';
import 'package:cholay_ice_sale/common/themes/app_color.dart';
import 'package:cholay_ice_sale/core/models/customer.dart';
import 'package:cholay_ice_sale/screens/setting/customer_names/customer_edit_widget.dart';
import 'package:cholay_ice_sale/screens/setting/customer_names/customer_names_viewmodel.dart';
import 'package:cholay_ice_sale/widgets/body_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/decoration.dart';
import '../../../common/constants/style.dart';
import '../../../common/constants/translation_constants.dart';
import '../../../core/services/confirm_delete_tran.dart';

class CustomerNamesView extends StatelessWidget {
  const CustomerNamesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomerNamesViewModel customerNamesViewModel =
        Provider.of<CustomerNamesViewModel>(context);
    List<Customer> customerList = customerNamesViewModel.customerList;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            TranslationConstants.customerNames.t(context),
            style: boldTextStyle(size: 16, color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomerEditScreen(
                            customerNamesViewModel: customerNamesViewModel),
                      ));
                },
                icon: const Icon(Icons.add, color: Colors.white)),
            const SizedBox(width: 10),
          ],
        ),
        body: BodyWidget(
          appError: customerNamesViewModel.appError,
          child: Container(
            //margin: EdgeInsets.only(top: 90),
            // decoration: boxDecorationWithRoundedCorners(
            //     borderRadius:
            //         const BorderRadius.only(topRight: Radius.circular(50))),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 3),
                          itemCount: customerList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 2),
                              decoration: boxDecorationRoundedWithShadow(2),
                              child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                leading: SizedBox(
                                  width: 120,
                                  child: Text(
                                      '${index + 1}. ${customerList[index].name}',
                                      // overflow: TextOverflow.visible,
                                      style: boldTextStyle(
                                          color: AppColor.primaryColor,
                                          size: 14,
                                          height: 1.5)),
                                ),
                                title: Text(
                                  '${customerList[index].buyingProduct}',
                                  style: secondaryTextStyle(size: 13),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text(
                                    //   'Amount  : ',
                                    //   style: secondaryTextStyle(size: 13),
                                    // ),
                                    // const SizedBox(height: 5),
                                    SizedBox(
                                      child: Row(
                                        children: [
                                          Text(
                                            customerList[index].phNo,
                                            style: secondaryTextStyle(size: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                                trailing: SizedBox(
                                  width: 55,
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CustomerEditScreen(
                                                        customer:
                                                            customerList[index],
                                                        customerNamesViewModel:
                                                            customerNamesViewModel),
                                              ));
                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.green,
                                        ),
                                      ),
                                      const Spacer(),
                                      InkWell(
                                        onTap: () async {
                                          if (await confirmDeleteTran(
                                              context)) {
                                            customerNamesViewModel
                                                .deleteCustomer(
                                                    customer:
                                                        customerList[index]);
                                          }
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      //const SizedBox(height: 60),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Expanded(
                  //       child: ElevatedButton(
                  //         onPressed: () {
                  //           // Navigator.push(
                  //           //     context,
                  //           //     MaterialPageRoute(
                  //           //         builder: (context) => SetEditScreen()));
                  //         },
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(12.0),
                  //           child: Text(
                  //             'AddNewShop',
                  //             style: primaryTextStyle(
                  //                 size: 14, height: 1, color: Colors.white),
                  //           ),
                  //         ),
                  //         style: ElevatedButton.styleFrom(
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10.0),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
