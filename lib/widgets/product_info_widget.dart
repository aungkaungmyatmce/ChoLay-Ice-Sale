import 'package:cholay_ice_sale/common/constants/translation_constants.dart';
import 'package:cholay_ice_sale/common/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cholay_ice_sale/core/models/product.dart';
import '../common/constants/decoration.dart';
import '../common/constants/style.dart';
import '../screens/printer/sale_print_viewmodel.dart';

class ProductInfoWidget extends StatefulWidget {
  ProductInfoWidget({
    super.key,
    required this.productNameController,
    required this.amountController,
    required this.priceController,
    required this.totalController,
  });

  final TextEditingController productNameController;
  final TextEditingController amountController;
  final TextEditingController priceController;
  final TextEditingController totalController;

  @override
  State<ProductInfoWidget> createState() => _ProductInfoWidgetState();
}

class _ProductInfoWidgetState extends State<ProductInfoWidget> {
  final _amountFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final salePrintViewModel = Provider.of<SalePrintViewModel>(context);

    return Container(
      decoration: boxDecorationWithRoundedCorners(
        backgroundColor: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 5),
            child: SizedBox(
              width: 160,
              height: 65,
              child: DropdownButtonFormField(
                isExpanded: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                hint: Text(TranslationConstants.product.t(context)),
                items: salePrintViewModel.productList.map((Product product) {
                  return DropdownMenuItem(
                    value: product.name,
                    child: Text(
                      product.name,
                      overflow: TextOverflow.ellipsis,
                      style: secondaryTextStyle(),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  widget.productNameController.text = newValue!;
                  Product product = salePrintViewModel.productList
                      .firstWhere((product) => product.name == newValue);
                  widget.priceController.text = product.price.toString();
                  setState(() {});
                  FocusScope.of(context).requestFocus(_amountFocusNode);
                },
                value: widget.productNameController.text.isNotEmpty
                    ? widget.productNameController.text
                    : null,
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: 60,
            child: TextField(
              focusNode: _amountFocusNode,
              controller: widget.amountController,
              keyboardType: TextInputType.number,
              style: secondaryTextStyle(),
              decoration: InputDecoration(
                hintText: TranslationConstants.amount.t(context),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
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
          SizedBox(
            height: 50,
            width: 70,
            child: TextField(
                controller: widget.priceController,
                keyboardType: TextInputType.number,
                style: secondaryTextStyle(),
                decoration: InputDecoration(
                  hintText: TranslationConstants.price.t(context),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                onChanged: (value) {
                  widget.priceController.text = value;
                  if (widget.priceController.text.isNotEmpty &&
                      value.isNotEmpty) {
                    widget.totalController.text =
                        (int.parse(widget.amountController.text) *
                                int.parse(value))
                            .toString();
                  } else {
                    widget.totalController.text = '';
                  }
                }),
          ),
          SizedBox(
            height: 50,
            width: 70,
            child: TextField(
              controller: widget.totalController,
              keyboardType: TextInputType.number,
              style: secondaryTextStyle(),
              decoration: const InputDecoration(
                hintText: 'စုစုပေါင်း',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
              onChanged: (value) {
                widget.totalController.text = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}
