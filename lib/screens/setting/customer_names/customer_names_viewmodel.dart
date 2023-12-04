import 'package:cholay_ice_sale/core/models/product.dart';
import 'package:cholay_ice_sale/core/repositories/customer_repository.dart';
import 'package:cholay_ice_sale/core/repositories/product_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/models/app_error.dart';
import '../../../core/models/customer.dart';
import '../../../di/get_it.dart';

class CustomerNamesViewModel with ChangeNotifier {
  CustomerRepository customerRepository = getItInstance<CustomerRepository>();
  ProductRepository productRepository = getItInstance<ProductRepository>();
  List<Customer> customerList = [];
  List<Product> productList = [];
  AppError appError = AppError(AppErrorType.initial);

  CustomerNamesViewModel() {
    getData();
  }

  Future<void> getData() async {
    appError = AppError(AppErrorType.loading);
    Either response = await customerRepository.getCustomerList();
    response.fold((l) => appError = l, (r) {
      appError = AppError(AppErrorType.initial);
      return customerList = r;
    });

    response = await productRepository.getProductList();
    response.fold((l) => appError = l, (r) {
      appError = AppError(AppErrorType.initial);
      return productList = r;
    });
    notifyListeners();
  }

  Future<void> editCustomerList(
      {Customer? oldCustomer, required Customer newCustomer}) async {
    if (oldCustomer != null) {
      customerList.removeWhere((shop) => shop == oldCustomer);
    }
    customerList.add(newCustomer);
    await customerRepository.updateCustomerList(customerList: customerList);
    notifyListeners();
  }

  Future<void> deleteCustomer({required Customer customer}) async {
    customerList.removeWhere((sh) => sh == customer);
    await customerRepository.updateCustomerList(customerList: customerList);
    notifyListeners();
  }
}
