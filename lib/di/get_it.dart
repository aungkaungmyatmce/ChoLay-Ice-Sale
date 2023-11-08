import 'package:cholay_ice_sale/core/data_sources/customer_remote_datasource.dart';
import 'package:cholay_ice_sale/core/data_sources/order_remote_datasource.dart';
import 'package:cholay_ice_sale/core/data_sources/product_remote_datasource.dart';
import 'package:cholay_ice_sale/core/data_sources/target_remote_datasource.dart';
import 'package:cholay_ice_sale/core/data_sources/transactions_remote_datesource.dart';
import 'package:cholay_ice_sale/core/repositories/customer_repository.dart';
import 'package:cholay_ice_sale/core/repositories/order_repository.dart';
import 'package:cholay_ice_sale/core/repositories/product_repository.dart';
import 'package:cholay_ice_sale/core/repositories/target_repository.dart';
import 'package:cholay_ice_sale/core/repositories/transaction_repository.dart';
import 'package:get_it/get_it.dart';

final getItInstance = GetIt.I;

Future init() async {
  /// Data Source
  getItInstance.registerLazySingleton<CustomerRemoteDataSource>(
      () => CustomerRemoteDataSourceImpl());
  getItInstance.registerLazySingleton<OrderRemoteDataSource>(
      () => OrderRemoteDataSourceImpl());
  getItInstance.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl());
  getItInstance.registerLazySingleton<TargetRemoteDataSource>(
      () => TargetRemoteDataSourceImpl());
  getItInstance.registerLazySingleton<TransactionRemoteDataSource>(
      () => TransactionRemoteDataSourceImpl());

  ///Repository
  getItInstance.registerLazySingleton<CustomerRepository>(
      () => CustomerRepositoryImpl(getItInstance()));
  getItInstance.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(getItInstance()));
  getItInstance.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(getItInstance()));
  getItInstance.registerLazySingleton<TargetRepository>(
      () => TargetRepositoryImpl(getItInstance()));
  getItInstance.registerLazySingleton<TransactionRepository>(
      () => TransactionRepositoryImpl(getItInstance()));
}
