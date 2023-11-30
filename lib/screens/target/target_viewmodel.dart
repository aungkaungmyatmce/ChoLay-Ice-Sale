import 'package:cholay_ice_sale/core/models/app_error.dart';
import 'package:cholay_ice_sale/core/models/customer.dart';
import 'package:cholay_ice_sale/core/models/targets/transport_target.dart';
import 'package:cholay_ice_sale/core/models/transactions/sale_transaction.dart';
import 'package:cholay_ice_sale/core/repositories/customer_repository.dart';
import 'package:cholay_ice_sale/core/repositories/target_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/models/targets/sale_target.dart';
import '../../core/repositories/transaction_repository.dart';
import '../../di/get_it.dart';

class TargetViewModel with ChangeNotifier {
  TargetRepository targetRepository = getItInstance<TargetRepository>();
  TransactionRepository transactionRepository =
      getItInstance<TransactionRepository>();
  CustomerRepository customerRepository = getItInstance<CustomerRepository>();

  List<SaleTarget> saleTargetList = [];
  List<TransportTarget> transportTargetList = [];
  List<SaleTransaction> saleTransactionList = [];
  List<Customer> customerList = [];
  DateTime selectedMonth = DateTime.now();
  AppError? appError;
  TargetViewModel() {
    getData();
  }

  Future<void> getData() async {
    Either response =
        await targetRepository.getSaleTargetList(tranMonth: selectedMonth);
    response.fold((l) => appError = l, (r) => saleTargetList = r);
    response =
        await targetRepository.getTransportTargetList(tranMonth: selectedMonth);
    response.fold((l) => appError = l, (r) => transportTargetList = r);
    response = await transactionRepository.getSaleTransactions(
        tranMonth: selectedMonth);
    response.fold((l) => appError = l, (r) => saleTransactionList = r);
    response = await customerRepository.getCustomerList();
    response.fold((l) => appError = l, (r) => customerList = r);

    routeList();
    notifyListeners();
  }

  void changeMonth(DateTime month) {
    selectedMonth = month;
    getData();
    notifyListeners();
  }

  Map<String, int> productsSoldAmount() {
    Map<String, int> productSold = {};
    saleTargetList.forEach((tran) {
      productSold[tran.productName] = 0;
    });

    //productSold = saleTargetList.map((target) => target.productName).toList();

    saleTransactionList.forEach((tran) {
      productSold[tran.productName] =
          (productSold[tran.productName]! + tran.quantity);
    });

    return productSold;
  }

  List<Map<String, dynamic>> transportTargetReach() {
    List<Map<String, dynamic>> targetReach = [];
    transportTargetList.forEach((target) {
      targetReach.add({
        'level': target.targetLevel,
        'startingTime': DateTime(
            2023, 12, 1, target.startingTime.hour, target.startingTime.minute),
        'reachDays': 0,
        'targetDays': target.days,
        'isReached': false,
      });
    });
    for (var transaction in saleTransactionList) {
      DateTime sendHour = DateTime(
          2023, 12, 1, transaction.tranDate.hour, transaction.tranDate.minute);
      for (var target in targetReach) {
        if (sendHour.isBefore(target['startingTime'])) {
          target['reachDays'] = target['reachDays'] + 1;
        }
        if (target['reachDays'] >= target['targetDays']) {
          target['isReached'] = true;
        }
      }
    }

    return targetReach;
  }

  List<Map<String, dynamic>> routeList({bool isAllList = true}) {
    List<String> inTownCustomerList = [];
    List<String> productNames = [];
    Map<String, dynamic> productNameAndAmount = {};

    for (var customer in customerList) {
      if (!customer.isInAnisakhan()) {
        inTownCustomerList.add(customer.name);
      }

      if (!productNames.contains(customer.buyingProduct) &&
          customer.buyingProduct != null) {
        productNames.add(customer.buyingProduct!);
        productNameAndAmount.putIfAbsent(customer.buyingProduct!, () => 0);
      }
    }

    List<Map<String, dynamic>> dailyRouteList = [];

    for (int day = 31; day >= 0; day--) {
      int totalNoOfCustomers = 0;
      productNameAndAmount.forEach((key, value) {
        productNameAndAmount[key] = 0;
      });

      List<String> cusList = [];
      List<SaleTransaction> dayList = saleTransactionList
          .where((tran) => tran.tranDate.day == day)
          .toList();
      dayList.sort((a, b) => a.tranDate.compareTo(b.tranDate));

      if (dayList.isNotEmpty) {
        for (var dayTran in dayList) {
          if (isAllList ||
              (!isAllList &&
                  inTownCustomerList.contains(dayTran.customerName))) {
            totalNoOfCustomers += dayTran.totalPrice;
            productNameAndAmount[dayTran.productName] =
                productNameAndAmount[dayTran.productName] + dayTran.quantity;

            if (!cusList.contains(dayTran.customerName)) {
              cusList.add(dayTran.customerName);
            }
          }
        }

        Map<String, dynamic> dayMap = {
          'date': dayList.first.tranDate.subtract(Duration(minutes: 15)),
          'totalCustomers': cusList.length,
          'totalProducts':
              productNameAndAmount.map((key, value) => MapEntry(key, value)),
        };
        dailyRouteList.add(dayMap);
      }
    }

    return dailyRouteList;
  }
}
