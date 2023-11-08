import 'dart:io';
import '../data_sources/order_remote_datasource.dart';
import '../models/app_error.dart';
import 'package:dartz/dartz.dart' hide Order;
import '../models/order.dart';

abstract class OrderRepository {
  Future<Either<AppError, List<Order>>> getOrderList();
  Future<Either<AppError, void>> addOrder({required Order order});
  Future<Either<AppError, void>> deleteOrder({required Order order});
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
  Future<Either<AppError, void>> addOrder({required Order order}) async {
    try {
      final response = await remoteDataSource.addOrder(order: order);
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> deleteOrder({required Order order})async {
    try {
      final response = await remoteDataSource.deleteOrder(
          order: order);
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }
}
