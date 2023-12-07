import 'package:cholay_ice_sale/common/themes/app_color.dart';
import 'package:cholay_ice_sale/core/models/app_error.dart';
import 'package:cholay_ice_sale/core/models/product.dart';
import 'package:cholay_ice_sale/core/repositories/customer_repository.dart';
import 'package:cholay_ice_sale/core/repositories/product_repository.dart';
import 'package:cholay_ice_sale/core/repositories/transaction_repository.dart';
import 'package:cholay_ice_sale/core/services/location_service.dart';
import 'package:cholay_ice_sale/core/services/printer_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:dartz/dartz.dart' hide Order;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../core/models/customer.dart';
import '../../core/models/order.dart';
import '../../core/models/transactions/sale_transaction.dart';
import '../../di/get_it.dart';

class SalePrintViewModel with ChangeNotifier {
  final Order? order;
  SalePrintViewModel({this.order}) {
    getData();

    if (order != null) {
      customerNameController.text = order!.customerName;
      for (var product in order!.products) {
        int index = order!.products.indexOf(product);
        if (index != order!.products.length - 1) {
          addProductTransaction();
        }
        productNameController[index].text = product.productName;
        quantityController[index].text = product.quantity.toString();
        priceController[index].text = product.price.toString();
        totalController[index].text =
            (product.price! * product.quantity).toString();
      }
    } else {
      getCurrentPosition();
    }
  }

  late PrinterService printerService;
  CustomerRepository customerRepository = getItInstance<CustomerRepository>();
  ProductRepository productRepository = getItInstance<ProductRepository>();
  TransactionRepository transactionRepository =
      getItInstance<TransactionRepository>();

  bool isSaveData = true;
  int tranNum = 0;
  TextEditingController customerNameController = TextEditingController();
  List<TextEditingController> productNameController = [TextEditingController()];
  List<TextEditingController> quantityController = [TextEditingController()];
  List<TextEditingController> priceController = [TextEditingController()];
  List<TextEditingController> totalController = [TextEditingController()];

  List<Customer> customerList = [];
  List<Product> productList = [];
  int totalSum = 0;
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;
  Position? curPosition;

  Future<void> getCurrentPosition() async {
    curPosition = await LocationService.getCurrentLocation();
    autoSelectCustomer();
  }

  Future<void> getData() async {
    Either response = await customerRepository.getCustomerList();
    response.fold((l) => AppError(l), (r) => customerList = r);

    Either proResponse = await productRepository.getProductList();
    proResponse.fold((l) => AppError(l), (r) => productList = r);

    notifyListeners();
  }

  void autoSelectCustomer() {
    if (curPosition != null) {
      List<Customer> nearCustomerList = [];
      customerList.forEach((customer) {
        if (customer.isNear(curPosition!)) {
          nearCustomerList.add(customer);
        }
      });
      if (nearCustomerList.isNotEmpty) {
        Customer cus =
            LocationService.findNearestCustomer(curPosition!, nearCustomerList);
        selectCustomer(cus.name);
      }
    }
  }

  void changeSave() {
    isSaveData = !isSaveData;
    notifyListeners();
  }

  void addProductTransaction() {
    if (tranNum >= 0 && tranNum < 4) {
      tranNum += 1;
      productNameController.add(TextEditingController());
      quantityController.add(TextEditingController());
      priceController.add(TextEditingController());
      totalController.add(TextEditingController());
    }
    notifyListeners();
  }

  void removeProductTransaction() {
    if (tranNum > 0) {
      tranNum -= 1;
      productNameController.removeLast();
      quantityController.removeLast();
      priceController.removeLast();
      totalController.removeLast();
    }
    notifyListeners();
  }

  void selectCustomer(String name) {
    customerNameController.text = name;
    Customer customer = customerList.firstWhere((cus) => cus.name == name);
    Product product =
        productList.firstWhere((pro) => pro.name == customer.buyingProduct);
    productNameController.first.text = product.name ?? '';
    priceController.first.text = product.price.toString() ?? '';
    notifyListeners();
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

  Future<void> saveAndPrint(BuildContext context) async {
    int totalPrice = 0;

    List<SaleTransaction> saleTranList = [];
    for (int i = 0; i <= tranNum; i++) {
      totalPrice = 0;
      if (totalController[i].text.isNotEmpty) {
        totalPrice += (int.parse(quantityController[i].text) *
            int.parse(priceController[i].text));
        saleTranList.add(SaleTransaction(
          customerName: customerNameController.text,
          tranDate: selectedDate,
          productName: productNameController[i].text,
          quantity: int.parse(quantityController[i].text),
          price: int.parse(priceController[i].text),
          totalPrice: totalPrice,
        ));
      }
    }
    if (totalPrice == 0 || customerNameController.text.isEmpty) {
      return;
    }

    isLoading = true;
    notifyListeners();
    if (isSaveData) {
      for (var saleTran in saleTranList) {
        await transactionRepository.addSaleTransaction(
            tranMonth: selectedDate, saleTran: saleTran);
      }
    }
    printerService.printReceipt(saleTranList);
    isLoading = false;
    notifyListeners();
    Navigator.of(context).pop(true);
  }
}
