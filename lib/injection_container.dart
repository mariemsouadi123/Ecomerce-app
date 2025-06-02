import 'package:ecommerce_app/features/products/domain/usecases/get_products.dart';
import 'package:ecommerce_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:ecommerce_app/core/network/dio_client.dart';
import 'package:ecommerce_app/features/products/data/datasources/product_remote_data_source.dart';
import 'package:ecommerce_app/features/products/data/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/products/domain/repositories/product_repository.dart';


final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  getIt.registerSingleton<Dio>(DioClient().dio);
  getIt.registerSingleton<ProductRemoteDataSource>(
      ProductRemoteDataSourceImpl(dioClient: DioClient()));
  getIt.registerSingleton<ProductRepository>(
    ProductRepositoryImpl(remoteDataSource: getIt()));
  getIt.registerSingleton<GetProducts>(GetProducts(getIt<ProductRepository>()));
  

   getIt.registerFactory<ProductBloc>(
    () => ProductBloc(getProducts: getIt<GetProducts>())
  );
}