import 'package:ecommerce_app/features/ecommerce/data/datasources/database_helper.dart';
import 'package:ecommerce_app/features/ecommerce/domain/entities/FavoriteProduct.dart';
import 'package:ecommerce_app/features/ecommerce/domain/entities/product.dart';
import 'package:ecommerce_app/features/ecommerce/domain/repositories/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final DatabaseHelper databaseHelper;

  FavoriteRepositoryImpl({required this.databaseHelper});

  @override
  Future<void> addToFavorites(Product product) async {
    await databaseHelper.insertFavoriteProduct(product);
  }

  @override
  Future<void> removeFromFavorites(int productId) async {
    await databaseHelper.removeFavoriteProduct(productId);
  }

  @override
  Future<List<FavoriteProduct>> getFavorites() async {
    final favorites = await databaseHelper.getFavoriteProducts();
    return favorites.map((f) => FavoriteProduct(
      product: Product.fromMap(f),
      addedAt: DateTime.parse(f['added_at']),
    )).toList();
  }

  @override
  Future<bool> isFavorite(int productId) async {
    return await databaseHelper.isProductFavorite(productId);
  }
}