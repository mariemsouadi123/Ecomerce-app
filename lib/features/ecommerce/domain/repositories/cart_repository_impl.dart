import 'package:ecommerce_app/features/ecommerce/data/datasources/cart_local_data_source.dart';

import '../../domain/repositories/cart_repository.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/product.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addToCart(Product product) async {
    await localDataSource.addToCart(product);
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    return await localDataSource.getCartItems();
  }

  @override
  Future<int> getCartItemsCount() async {
    return await localDataSource.getCartItemsCount();
  }
}