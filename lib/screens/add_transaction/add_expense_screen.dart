import 'package:cholay_ice_sale/common/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants/decoration.dart';
import 'add_transaction_viewmodel.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addTransactionViewModel =
        Provider.of<AddTransactionViewModel>(context);
    return Form(
      key: addTransactionViewModel.form,
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            //padding: EdgeInsets.only(top: 10, bottom: 14, left: 7, right: 7),
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    TextFormField(
                      controller: addTransactionViewModel.expenseNameController,
                      decoration: InputDecoration(
                        labelStyle: secondaryTextStyle(),
                        labelText: 'Name',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please fill this field';
                        }
                        return null;
                      },
                      style: secondaryTextStyle(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFormField(
                  focusNode: addTransactionViewModel.amountFocusNode,
                  controller: addTransactionViewModel.expenseAmountController,
                  decoration: InputDecoration(
                    labelStyle: secondaryTextStyle(),
                    labelText: 'Amount',
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill this field';
                    }
                    return null;
                  },
                  style: secondaryTextStyle(),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: addTransactionViewModel.expenseNoteController,
                  focusNode: addTransactionViewModel.noteFocusNode,
                  decoration: InputDecoration(
                    labelStyle: secondaryTextStyle(),
                    labelText: 'Note',
                  ),
                  textInputAction: TextInputAction.next,
                  style: secondaryTextStyle(),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () =>
                  addTransactionViewModel.saveExpenseTransaction(context),
              child: addTransactionViewModel.isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ))
        ],
      ),
    );
  }
}
