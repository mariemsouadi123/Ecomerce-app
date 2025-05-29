import 'package:ecommerce_app/features/ecommerce/domain/entities/product.dart';
import 'package:ecommerce_app/features/ecommerce/domain/repositories/favorite_repository.dart';

class AddToFavorites {
  final FavoriteRepository repository;

  AddToFavorites(this.repository);

  Future<void> call(Product product) async {
    return await repository.addToFavorites(product);
  }
}