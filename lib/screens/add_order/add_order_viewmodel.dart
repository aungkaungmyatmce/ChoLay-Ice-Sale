import 'package:cholay_ice_sale/core/models/order.dart';
import 'package:cholay_ice_sale/core/models/transactions/product_transaction.dart';
import 'package:dartz/dartz.dart' hide Order;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/themes/app_color.dart';
import '../../core/models/app_error.dart';
import '../../core/models/customer.dart';
import '../../core/models/product.dart';
import '../../core/repositories/customer_repository.dart';
import '../../core/repositories/order_repository.dart';
import '../../core/repositories/product_repository.dart';
import '../../di/get_it.dart';

class AddOrderViewModel with ChangeNotifier {
  AddOrderViewModel() {
    getData();
  }
  CustomerRepository customerRepository = getItInstance<CustomerRepository>();
  ProductRepository productRepository = getItInstance<ProductRepository>();
  OrderRepository orderRepository = getItInstance<OrderRepository>();

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

  Future<void> getData() async {
    Either response = await customerRepository.getCustomerList();
    response.fold((l) => AppError(l), (r) => customerList = r);

    Either proResponse = await productRepository.getProductList();
    proResponse.fold((l) => AppError(l), (r) => productList = r);

    notifyListeners();
  }

  void changeSave() {
    isSaveData = !isSaveData;
    notifyListeners();
  }

  void addOrderTransaction() {
    if (tranNum >= 0 && tranNum < 2) {
      tranNum += 1;
      productNameController.add(TextEditingController());
      quantityController.add(TextEditingController());
      priceController.add(TextEditingController());
      totalController.add(TextEditingController());
    }
    notifyListeners();
  }

  void removeOrderTransaction() {
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
    Product? product = productList
        .firstWhereOrNull((pro) => pro.name == customer.buyingProduct);
    if (product != null) {
      productNameController.first.text = product.name ?? '';
      priceController.first.text = product.price.toString() ?? '';
    }

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

  Future<void> saveOrder(BuildContext context) async {
    // int totalPrice = 0;
    //
    Order order;
    List<ProductInfo> productList = [];
    for (int i = 0; i <= tranNum; i++) {
      if (productNameController[i].text.isNotEmpty &&
          quantityController[i].text.isNotEmpty) {
        productList.add(ProductInfo(
          productName: productNameController[i].text,
          quantity: int.parse(quantityController[i].text),
          price: int.parse(priceController[i].text),
        ));
      }
    }
    order = Order(
        customerName: customerNameController.text,
        products: productList,
        orderTime: selectedDate);
    isLoading = true;
    notifyListeners();
    await orderRepository.addOrder(order: order);
    isLoading = false;
    notifyListeners();
    Navigator.of(context).pop(true);
  }
}
