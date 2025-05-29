import 'package:ecommerce_app/features/ecommerce/domain/repositories/favorite_repository.dart';

class IsProductFavorite {
  final FavoriteRepository repository;

  IsProductFavorite(this.repository);

  Future<bool> call(int productId) async {
    return await repository.isFavorite(productId);
  }
}