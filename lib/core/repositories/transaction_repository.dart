import 'dart:io';
import 'package:cholay_ice_sale/core/data_sources/transactions_remote_datesource.dart';
import 'package:cholay_ice_sale/core/models/app_error.dart';
import 'package:dartz/dartz.dart';
import '../models/transactions/expense_transaction.dart';
import '../models/transactions/sale_transaction.dart';

abstract class TransactionRepository {
  Future<Either<AppError, List<SaleTransaction>>> getSaleTransactions(
      {required DateTime tranMonth});
  Future<Either<AppError, void>> addSaleTransaction(
      {required DateTime tranMonth, required SaleTransaction saleTran});
  Future<Either<AppError, void>> deleteSaleTransaction(
      {required DateTime tranMonth, required SaleTransaction saleTran});

  Future<Either<AppError, List<ExpenseTransaction>>> getExpenseTransactions(
      {required DateTime tranMonth});
  Future<Either<AppError, void>> addExpenseTransaction(
      {required DateTime tranMonth, required ExpenseTransaction expenseTran});
  Future<Either<AppError, void>> deleteExpenseTransaction(
      {required DateTime tranMonth, required ExpenseTransaction expenseTran});
}

class TransactionRepositoryImpl extends TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, List<SaleTransaction>>> getSaleTransactions(
      {required DateTime tranMonth}) async {
    try {
      final list =
          await remoteDataSource.getSaleTransactions(tranMonth: tranMonth);
      return Right(list);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> addSaleTransaction(
      {required DateTime tranMonth, required SaleTransaction saleTran}) async {
    try {
      final response = await remoteDataSource.addSaleTransaction(
          tranMonth: tranMonth, saleTran: saleTran);
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> deleteSaleTransaction(
      {required DateTime tranMonth, required SaleTransaction saleTran}) async {
    try {
      final response = await remoteDataSource.deleteSaleTransaction(
          tranMonth: tranMonth, saleTran: saleTran);
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, List<ExpenseTransaction>>> getExpenseTransactions(
      {required DateTime tranMonth}) async {
    try {
      final list =
          await remoteDataSource.getExpenseTransactions(tranMonth: tranMonth);
      return Right(list);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> addExpenseTransaction(
      {required DateTime tranMonth,
      required ExpenseTransaction expenseTran}) async {
    try {
      final response = await remoteDataSource.addExpenseTransaction(
          tranMonth: tranMonth, expenseTran: expenseTran);
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> deleteExpenseTransaction(
      {required DateTime tranMonth,
      required ExpenseTransaction expenseTran}) async {
    try {
      final response = await remoteDataSource.deleteExpenseTransaction(
          tranMonth: tranMonth, expenseTran: expenseTran);
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }
}
