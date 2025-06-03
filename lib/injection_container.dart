import 'package:ecommerce_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:ecommerce_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/add_to_cart.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/get_cart_items.dart';
import 'package:ecommerce_app/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:ecommerce_app/features/cart/presentation/bloc/cart_bloc.dart';
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

  getIt.registerSingleton<CartRepository>(CartRepositoryImpl());
  getIt.registerSingleton<AddToCart>(AddToCart(getIt<CartRepository>()));
  getIt.registerSingleton<GetCartItems>(GetCartItems(getIt<CartRepository>()));
  getIt.registerSingleton<RemoveFromCart>(RemoveFromCart(getIt<CartRepository>()));
  
  getIt.registerFactory<CartBloc>(
    () => CartBloc(
      addToCart: getIt<AddToCart>(),
      getCartItems: getIt<GetCartItems>(),
      removeFromCart: getIt<RemoveFromCart>(),
    ),
  );
}