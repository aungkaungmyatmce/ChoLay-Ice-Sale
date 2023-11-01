import 'dart:io';
import 'package:cholay_ice_sale/core/data_sources/product_remote_datasource.dart';
import 'package:cholay_ice_sale/core/models/product.dart';
import 'package:dartz/dartz.dart';
import '../models/app_error.dart';

abstract class ProductRepository {
  Future<Either<AppError, List<Product>>> getProductList();
  Future<Either<AppError, void>> updateProductList(
      {required List<Product> productList});
}

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<AppError, List<Product>>> getProductList() async {
    try {
      final list = await remoteDataSource.getProductList();
      return Right(list);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }

  @override
  Future<Either<AppError, void>> updateProductList(
      {required List<Product> productList}) async {
    try {
      final response =
          remoteDataSource.updateProductList(productList: productList);
      return Right(response);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.database));
    }
  }
}
