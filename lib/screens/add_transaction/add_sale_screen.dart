import 'package:cholay_ice_sale/commom/themes/app_color.dart';
import 'package:cholay_ice_sale/core/models/product.dart';
import 'package:cholay_ice_sale/screens/add_transaction/add_transaction_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../commom/constants/decoration.dart';
import '../../commom/constants/style.dart';
import '../../core/models/customer.dart';

class AddSaleScreen extends StatelessWidget {
  AddSaleScreen({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final addTransactionViewModel =
        Provider.of<AddTransactionViewModel>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              //shrinkWrap: true,
              children: [
                const SizedBox(height: 15),
                for (int i = 0; i <= addTransactionViewModel.tranNum; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: AddIncomeWidget(
                      num: i + 1,
                      customerController:
                          addTransactionViewModel.customerNameController[i],
                      quantityController:
                          addTransactionViewModel.quantityController[i],
                      priceController:
                          addTransactionViewModel.priceController[i],
                      productController:
                          addTransactionViewModel.productNameController[i],
                      totalController:
                          addTransactionViewModel.totalController[i],
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (addTransactionViewModel.tranNum < 4)
                      IconButton(
                          onPressed: () {
                            _scrollController.jumpTo(
                                _scrollController.position.maxScrollExtent);
                            addTransactionViewModel.addSaleWidget();
                          },
                          icon: const Icon(
                            Icons.add,
                            color: AppColor.primaryColor,
                          )),
                    if (addTransactionViewModel.tranNum > 0)
                      IconButton(
                          onPressed: () {
                            addTransactionViewModel.removeSaleWidget();
                          },
                          icon: const Icon(
                            Icons.remove,
                            color: AppColor.primaryColor,
                          )),
                  ],
                ),
                SizedBox(height: 150),
              ],
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => addTransactionViewModel.saveSaleTransaction(context),
          style: ButtonStyle(
            // backgroundColor:
            // MaterialStateProperty.all(Theme.of(context).accentColor),
            elevation: MaterialStateProperty.all(0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: addTransactionViewModel.isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : const Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                ),
        ),
      ],
    );
  }
}

class AddIncomeWidget extends StatefulWidget {
  final int num;
  final TextEditingController customerController;
  final TextEditingController quantityController;
  final TextEditingController priceController;
  final TextEditingController productController;
  final TextEditingController totalController;

  const AddIncomeWidget({
    Key? key,
    required this.num,
    required this.customerController,
    required this.quantityController,
    required this.priceController,
    required this.productController,
    required this.totalController,
  }) : super(key: key);

  @override
  _AddIncomeWidgetState createState() => _AddIncomeWidgetState();
}

class _AddIncomeWidgetState extends State<AddIncomeWidget> {
  final _amountFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final addTransactionViewModel =
        Provider.of<AddTransactionViewModel>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.only(top: 10, bottom: 14, left: 7, right: 7),
      decoration: boxDecorationWithRoundedCorners(
        backgroundColor: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${widget.num.toString()}.', style: boldTextStyle()),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name', style: boldTextStyle(size: 14)),
                  Stack(
                    children: [
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: TextField(
                          controller: widget.customerController,
                          style: secondaryTextStyle(),
                          decoration: const InputDecoration(),
                        ),
                      ),
                      Positioned(
                          right: 0,
                          top: 4,
                          child: PopupMenuButton(
                            icon: const Icon(
                              Icons.expand_more,
                            ),
                            itemBuilder: (context) =>
                                addTransactionViewModel.customerList
                                    .map((customer) => PopupMenuItem(
                                          child: Text(customer.name,
                                              style: secondaryTextStyle()),
                                          value: customer,
                                        ))
                                    .toList(),
                            onSelected: (Customer cus) {
                              widget.customerController.text = cus.name;
                              widget.productController.text =
                                  cus.buyingProduct!;
                              Product pro = addTransactionViewModel.productList
                                  .firstWhere(
                                      (pro) => pro.name == cus.buyingProduct);
                              widget.priceController.text =
                                  pro.price.toString();
                              setState(() {});
                              FocusScope.of(context)
                                  .requestFocus(_amountFocusNode);
                            },
                          )),
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Product', style: boldTextStyle(size: 14)),
                  SizedBox(
                    width: 120,
                    height: 50,
                    child: DropdownButtonFormField(
                      value: widget.productController.text.isNotEmpty
                          ? widget.productController.text
                          : null,
                      isExpanded: true,
                      items: addTransactionViewModel.productList
                          .map((Product product) {
                        return DropdownMenuItem(
                            value: product.name,
                            child: Text(
                              product.name,
                              overflow: TextOverflow.ellipsis,
                              style: secondaryTextStyle(),
                            ));
                      }).toList(),
                      onChanged: (newValue) {
                        widget.productController.text = newValue!;
                        Product prod = addTransactionViewModel.productList
                            .firstWhere((prod) => prod.name == newValue);
                        widget.priceController.text = prod.price.toString();
                        if (widget.priceController.text.isNotEmpty &&
                            widget.quantityController.text.isNotEmpty) {
                          widget.totalController.text =
                              (int.parse(widget.priceController.text) *
                                      int.parse(widget.quantityController.text))
                                  .toString();
                        }
                        // FocusScope.of(context).requestFocus(_amountFocusNode);
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Amount', style: boldTextStyle(size: 14)),
                    SizedBox(
                      height: 30,
                      width: 65,
                      child: TextField(
                        focusNode: _amountFocusNode,
                        controller: widget.quantityController,
                        keyboardType: TextInputType.number,
                        style: secondaryTextStyle(),
                        decoration: const InputDecoration(),
                        onChanged: (value) {
                          if (widget.priceController.text.isNotEmpty &&
                              value.isNotEmpty) {
                            widget.totalController.text =
                                (int.parse(widget.priceController.text) *
                                        int.parse(value))
                                    .toString();
                          } else {
                            widget.totalController.text = '';
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price', style: boldTextStyle(size: 14)),
                    SizedBox(
                      height: 30,
                      width: 65,
                      child: TextField(
                          controller: widget.priceController,
                          keyboardType: TextInputType.number,
                          style: secondaryTextStyle(),
                          decoration: const InputDecoration(),
                          onChanged: (value) {
                            if (widget.priceController.text.isNotEmpty &&
                                value.isNotEmpty) {
                              widget.totalController.text =
                                  (int.parse(widget.quantityController.text) *
                                          int.parse(value))
                                      .toString();
                            } else {
                              widget.totalController.text = '';
                            }
                          }),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total', style: boldTextStyle(size: 14)),
                    SizedBox(
                      height: 30,
                      width: 65,
                      child: TextField(
                        controller: widget.totalController,
                        keyboardType: TextInputType.number,
                        style: secondaryTextStyle(),
                        decoration: const InputDecoration(),
                      ),
                    ),
                  ],
                ),
              ),
              //const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
