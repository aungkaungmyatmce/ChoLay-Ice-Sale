import 'dart:io';
import '../data_sources/order_remote_datasource.dart';
import '../models/app_error.dart';
import 'package:dartz/dartz.dart' hide Order;
import '../models/order.dart';

abstract class OrderRepository {
  Future<Either<AppError, List<Order>>> getOrderList();
  Future<Either<AppError, void>> updateOrderList(
      {required List<Order> orderList});
}

class OrderRepositoryImpl extends OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<AppError, List<Order>>> getOrderList() async {
    try {
      final list = await remoteDataSource.getOrderList();
      return Right(list);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> updateOrderList(
      {required List<Order> orderList}) async {
    try {
      final response = remoteDataSource.updateOrderList(orderList: orderList);
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }
}
