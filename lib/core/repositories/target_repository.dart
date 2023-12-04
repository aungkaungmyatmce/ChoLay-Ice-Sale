import 'dart:io';
import 'package:cholay_ice_sale/core/data_sources/target_remote_datasource.dart';
import 'package:cholay_ice_sale/core/models/app_error.dart';
import 'package:dartz/dartz.dart';
import '../models/targets/customer_target.dart';
import '../models/targets/sale_target.dart';
import '../models/targets/transport_target.dart';

abstract class TargetRepository {
  Future<Either<AppError, List<SaleTarget>>> getSaleTargetList(
      {required DateTime tranMonth});
  Future<Either<AppError, void>> updateSaleTargetList(
      {required List<SaleTarget> targetList});

  Future<Either<AppError, List<TransportTarget>>> getTransportTargetList(
      {required DateTime tranMonth});
  Future<Either<AppError, void>> updateTransportTargetList(
      {required List<TransportTarget> targetList});

  Future<Either<AppError, List<CustomerTarget>>> getCustomerTargetList(
      {required DateTime tranMonth});
  Future<Either<AppError, void>> updateCustomerTargetList(
      {required DateTime tranMonth, required List<CustomerTarget> targetList});
}

class TargetRepositoryImpl extends TargetRepository {
  final TargetRemoteDataSource remoteDataSource;

  TargetRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, List<SaleTarget>>> getSaleTargetList(
      {required DateTime tranMonth}) async {
    try {
      final list =
          await remoteDataSource.getSaleTargetList(targetMonth: tranMonth);
      return Right(list);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> updateSaleTargetList(
      {required List<SaleTarget> targetList}) async {
    try {
      final response =
          await remoteDataSource.updateSaleTargetList(targetList: targetList);
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, List<TransportTarget>>> getTransportTargetList(
      {required DateTime tranMonth}) async {
    try {
      final list =
          await remoteDataSource.getTransportTargetList(targetMonth: tranMonth);
      return Right(list);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> updateTransportTargetList(
      {required List<TransportTarget> targetList}) async {
    try {
      final response = await remoteDataSource.updateTransportTargetList(
          targetList: targetList);
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, List<CustomerTarget>>> getCustomerTargetList(
      {required DateTime tranMonth}) async {
    try {
      final list =
          await remoteDataSource.getCustomerTargetList(targetMonth: tranMonth);
      return Right(list);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> updateCustomerTargetList(
      {required DateTime tranMonth,
      required List<CustomerTarget> targetList}) async {
    try {
      final response = await remoteDataSource.updateCustomerTargetList(
          targetMonth: tranMonth, targetList: targetList);
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }
}
