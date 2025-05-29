import 'package:ecommerce_app/features/ecommerce/data/datasources/product_remote_data_source.dart';
import 'package:ecommerce_app/features/ecommerce/domain/repositories/cart_repository_impl.dart';
import 'package:ecommerce_app/features/ecommerce/domain/repositories/favorite_repository.dart';
import 'package:ecommerce_app/features/ecommerce/domain/repositories/favorite_repository_impl.dart';
import 'package:ecommerce_app/features/ecommerce/domain/repositories/product_repository_impl.dart';
import 'package:ecommerce_app/features/ecommerce/domain/usecases/add_to_favorite.dart';
import 'package:ecommerce_app/features/ecommerce/domain/usecases/get_class_items.dart';
import 'package:ecommerce_app/features/ecommerce/domain/usecases/get_favorite.dart';
import 'package:ecommerce_app/features/ecommerce/domain/usecases/is_product_favorite.dart';
import 'package:ecommerce_app/features/ecommerce/domain/usecases/remove_from_favorite.dart';
import 'package:ecommerce_app/features/ecommerce/presentation/bloc/cart_bloc.dart/cart_bloc.dart';
import 'package:ecommerce_app/features/ecommerce/presentation/bloc/favorite_bloc.dart/favorites_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'features/ecommerce/data/datasources/database_helper.dart';
import 'features/ecommerce/data/datasources/cart_local_data_source.dart';
import 'features/ecommerce/domain/repositories/cart_repository.dart';
import 'features/ecommerce/domain/repositories/product_repository.dart';
import 'features/ecommerce/domain/usecases/add_to_cart.dart';
import 'features/ecommerce/domain/usecases/get_cart_items_count.dart';
import 'features/ecommerce/domain/usecases/get_products.dart';
import 'features/ecommerce/presentation/bloc/product_bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => ProductBloc(getProducts: sl()),
  );
  sl.registerFactory(
  () => CartBloc(
    addToCart: sl(),
    getCartItemsCount: sl(),
    getCartItems: sl(), // Cette ligne est cruciale
  ),
);

  // Use cases
  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => AddToCart(sl()));
  sl.registerLazySingleton(() => GetCartItemsCount(sl()));
  sl.registerLazySingleton(() => GetCartItems(sl()));


  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(databaseHelper: sl()),
  );
  sl.registerLazySingleton(() => DatabaseHelper.instance);

  // Dans injection_container.dart
sl.registerLazySingleton<FavoriteRepository>(
  () => FavoriteRepositoryImpl(databaseHelper: sl()),
);


sl.registerLazySingleton(() => GetFavorites(sl()));
sl.registerLazySingleton(() => IsProductFavorite(sl()));

}