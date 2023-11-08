import 'package:cholay_ice_sale/screens/add_order/add_order_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cholay_ice_sale/core/models/product.dart';
import '../commom/constants/decoration.dart';
import '../commom/constants/style.dart';
import '../screens/printer/sale_print_viewmodel.dart';

class OrderInfoWidget extends StatefulWidget {
  OrderInfoWidget({
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
  State<OrderInfoWidget> createState() => _OrderInfoWidgetState();
}

class _OrderInfoWidgetState extends State<OrderInfoWidget> {
  final _amountFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final addOrderViewModel = Provider.of<AddOrderViewModel>(context);

    return Container(
      decoration: boxDecorationWithRoundedCorners(
        backgroundColor: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                hint: Text('Product'),
                items: addOrderViewModel.productList.map((Product product) {
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
                  Product product = addOrderViewModel.productList
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
            width: 65,
            child: TextField(
              focusNode: _amountFocusNode,
              controller: widget.amountController,
              keyboardType: TextInputType.number,
              style: secondaryTextStyle(),
              decoration: const InputDecoration(
                hintText: 'Amount',
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
          //SizedBox(width: 10),
        ],
      ),
    );
  }
}
