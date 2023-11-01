import 'dart:io';

import 'package:cholay_ice_sale/core/data_sources/customer_remote_datasource.dart';
import 'package:cholay_ice_sale/core/models/app_error.dart';
import 'package:dartz/dartz.dart';

import '../models/customer.dart';

abstract class CustomerRepository {
  Future<Either<AppError, List<Customer>>> getCustomerList();
  Future<Either<AppError, void>> updateCustomerList(
      {required List<Customer> customerList});
}

class CustomerRepositoryImpl extends CustomerRepository {
  final CustomerRemoteDataSource customerRemoteDataSource;
  CustomerRepositoryImpl(this.customerRemoteDataSource);
  @override
  Future<Either<AppError, List<Customer>>> getCustomerList() async {
    try {
      final list = await customerRemoteDataSource.getCustomerList();
      return Right(list);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> updateCustomerList(
      {required List<Customer> customerList}) async {
    try {
      final response = await customerRemoteDataSource.updateCustomerList(
          customerList: customerList);
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }
}
