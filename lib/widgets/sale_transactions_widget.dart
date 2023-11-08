import 'package:cholay_ice_sale/commom/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../commom/constants/decoration.dart';
import '../commom/constants/style.dart';
import '../core/services/confirm_delete_tran.dart';
import '../screens/transactions/transactions_viewmodel.dart';

// class SaleTransactionsWidget extends StatelessWidget {
//   final DateTime date;
//   const SaleTransactionsWidget({Key? key, required this.date})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<TransactionsViewModel>(
//         builder: (_, salePrintViewModel, __) {
//       List<Map<String, dynamic>> dailyTranList =
//           salePrintViewModel.saleTransactionsForOneMonth(date: date);
//       if (salePrintViewModel.isLoading) {
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(
//               width: 20,
//               height: 20,
//               child: CircularProgressIndicator(),
//             ),
//           ],
//         );
//       }
//       if (dailyTranList.isEmpty) {
//         return Center(
//             child: Text('No Transactions for this month!',
//                 style: secondaryTextStyle()));
//       }
//       return ListView.separated(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: dailyTranList.length,
//         separatorBuilder: (context, index) => const SizedBox(height: 10),
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(vertical: 1),
//             child: Container(
//               margin: const EdgeInsets.only(top: 10),
//               padding: const EdgeInsets.all(10),
//               decoration: boxDecorationRoundedWithShadow(12),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(dailyTranList[index]['date'],
//                           style: boldTextStyle(weight: FontWeight.w600)),
//                       Text(
//                         dailyTranList[index]['totalSum'].toString(),
//                         style:
//                             secondaryTextStyle(color: Colors.green, size: 15),
//                       ),
//                     ],
//                   ),
//                   const Divider(),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: dailyTranList[index]['tranList'].length,
//                     itemBuilder: (context, index2) {
//                       return Dismissible(
//                         key: UniqueKey(),
//                         confirmDismiss: (direction) {
//                           return confirmDeleteTran(context);
//                         },
//                         onDismissed: (direction) async {
//                           await salePrintViewModel.deleteSaleTran(
//                               dailyTranList[index]['tranList'][index2]);
//                         },
//                         direction: DismissDirection.endToStart,
//                         background: Container(
//                           decoration: BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: BorderRadius.circular(5)),
//                           child: const Icon(Icons.delete, color: Colors.white),
//                           alignment: Alignment.centerRight,
//                           padding: const EdgeInsets.symmetric(horizontal: 5),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 3),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               SizedBox(
//                                 width: MediaQuery.of(context).size.width / 1.7,
//                                 height: 32,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Expanded(
//                                       child: Text(
//                                           dailyTranList[index]['tranList']
//                                                   [index2]
//                                               .customerName,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: boldTextStyle(
//                                               height: 1.3, size: 15)),
//                                     ),
//                                     Container(
//                                       width: 90,
//                                       height: 32,
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 3, vertical: 2),
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(13),
//                                           border: Border.all(
//                                               color: Colors.black26)),
//                                       child: Center(
//                                         child: Text(
//                                           dailyTranList[index]['tranList']
//                                                   [index2]
//                                               .productName,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: secondaryTextStyle(
//                                               size: 12,
//                                               color: AppColor.primaryColor),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               const SizedBox(width: 5),
//                               SizedBox(
//                                 width: MediaQuery.of(context).size.width / 4,
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                         dailyTranList[index]['tranList'][index2]
//                                             .quantity
//                                             .toString(),
//                                         textAlign: TextAlign.end,
//                                         style: secondaryTextStyle()),
//                                     Text(
//                                         (dailyTranList[index]['tranList']
//                                                         [index2]
//                                                     .quantity *
//                                                 dailyTranList[index]['tranList']
//                                                         [index2]
//                                                     .price)
//                                             .toString(),
//                                         style: secondaryTextStyle()),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       );
//     });
//   }
// }
