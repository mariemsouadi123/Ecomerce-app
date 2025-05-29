import 'package:ecommerce_app/features/ecommerce/domain/entities/FavoriteProduct.dart';
import 'package:ecommerce_app/features/ecommerce/domain/entities/product.dart';

abstract class FavoriteRepository {
  Future<void> addToFavorites(Product product);
  Future<void> removeFromFavorites(int productId);
  Future<List<FavoriteProduct>> getFavorites();
  Future<bool> isFavorite(int productId);
}