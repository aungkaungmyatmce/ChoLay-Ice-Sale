import 'package:cholay_ice_sale/core/models/transactions/expense_transaction.dart';
import 'package:cholay_ice_sale/core/models/transactions/sale_transaction.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/themes/app_color.dart';
import '../../core/models/app_error.dart';
import '../../core/models/customer.dart';
import '../../core/models/product.dart';
import '../../core/repositories/customer_repository.dart';
import '../../core/repositories/product_repository.dart';
import '../../core/repositories/transaction_repository.dart';
import '../../di/get_it.dart';

class AddTransactionViewModel with ChangeNotifier {
  AddTransactionViewModel() {
    getData();
  }

  CustomerRepository customerRepository = getItInstance<CustomerRepository>();
  ProductRepository productRepository = getItInstance<ProductRepository>();
  TransactionRepository transactionRepository =
      getItInstance<TransactionRepository>();

  List<TextEditingController> customerNameController = [
    TextEditingController()
  ];
  List<TextEditingController> productNameController = [TextEditingController()];
  List<TextEditingController> quantityController = [TextEditingController()];
  List<TextEditingController> priceController = [TextEditingController()];
  List<TextEditingController> totalController = [TextEditingController()];

  List<Customer> customerList = [];
  List<Customer> sortedCustomerList = [];
  List<Product> productList = [];
  List<SaleTransaction> saleTransactionList = [];
  int totalSum = 0;
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;
  int tranNum = 0;

  final form = GlobalKey<FormState>();
  final expenseNameController = TextEditingController();
  final expenseAmountController = TextEditingController();
  final expenseNoteController = TextEditingController();
  final amountFocusNode = FocusNode();
  final noteFocusNode = FocusNode();
  AppError appError = AppError(AppErrorType.initial);

  Future<void> getData() async {
    Either response = await customerRepository.getCustomerList();
    response.fold((l) => appError = l, (r) => customerList = r);

    Either proResponse = await productRepository.getProductList();
    proResponse.fold((l) => appError = l, (r) => productList = r);

    Either tranResponse = await transactionRepository.getSaleTransactions(
        tranMonth: DateTime.now());
    tranResponse.fold((l) => appError = l, (r) => saleTransactionList = r);
    sortMostBuyCustomers();
    notifyListeners();
  }

  void sortMostBuyCustomers() {
    List<Map<String, dynamic>> customerMapList = [];
    List<SaleTransaction> transactionList = saleTransactionList
        .where((tran) => tran.tranDate.day == DateTime.now().day)
        .toList();

    for (var customer in customerList) {
      int num = 0;
      for (var tran in saleTransactionList) {
        if (tran.customerName == customer.name) {
          num += tran.quantity!;
        }
      }
      Map<String, dynamic> cus = {
        'name': customer,
        'num': num,
      };
      customerMapList.add(cus);
    }

    customerMapList.sort((a, b) => b['num'].compareTo(a['num']));
    sortedCustomerList =
        customerMapList.map((cus) => cus['name'] as Customer).toList();

    transactionList.forEach((tran) {
      Customer? cus = sortedCustomerList
          .firstWhereOrNull((cus) => cus.name == tran.customerName);
      if (cus != null) {
        sortedCustomerList.remove(cus);
        sortedCustomerList.add(cus);
      }
    });
  }

  void datePick(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(DateTime.now().year + 1),
      locale: Locale('en', 'US'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.primaryColor, // header background color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor.primaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      selectedDate = pickedDate;
      notifyListeners();
    });
  }

  void addSaleWidget() {
    if (tranNum >= 0 && tranNum < 4) {
      tranNum += 1;
      customerNameController.add(TextEditingController());
      productNameController.add(TextEditingController());
      quantityController.add(TextEditingController());
      priceController.add(TextEditingController());
      totalController.add(TextEditingController());
    }
    notifyListeners();
  }

  void removeSaleWidget() {
    if (tranNum > 0) {
      tranNum -= 1;
      customerNameController.removeLast();
      productNameController.removeLast();
      quantityController.removeLast();
      priceController.removeLast();
      totalController.removeLast();
    }
    notifyListeners();
  }

  Future<void> saveSaleTransaction(BuildContext context) async {
    List<SaleTransaction> saleTranList = [];
    for (int i = 0; i <= tranNum; i++) {
      if (customerNameController[i].text.isNotEmpty &&
          totalController[i].text.isNotEmpty) {
        saleTranList.add(SaleTransaction(
            customerName: customerNameController[i].text,
            tranDate: selectedDate,
            productName: productNameController[i].text,
            quantity: int.parse(quantityController[i].text),
            price: int.parse(priceController[i].text),
            totalPrice: int.parse(
              totalController[i].text,
            )));
      }
    }
    isLoading = true;
    notifyListeners();
    for (var tran in saleTranList) {
      await transactionRepository.addSaleTransaction(
          tranMonth: selectedDate, saleTran: tran);
    }
    isLoading = false;
    notifyListeners();
    Navigator.of(context).pop();
  }

  Future<void> saveExpenseTransaction(BuildContext context) async {
    if (form.currentState!.validate()) {
      ExpenseTransaction expTran = ExpenseTransaction(
        expenseName: expenseNameController.text,
        amount: int.parse(expenseAmountController.text),
        note: expenseNoteController.text,
        tranDate: selectedDate,
      );
      isLoading = true;
      notifyListeners();
      await transactionRepository.addExpenseTransaction(
          tranMonth: selectedDate, expenseTran: expTran);
      isLoading = false;
      notifyListeners();
      Navigator.of(context).pop(true);
    }
  }
}
