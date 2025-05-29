import 'package:ecommerce_app/features/ecommerce/domain/entities/FavoriteProduct.dart';
import 'package:ecommerce_app/features/ecommerce/domain/repositories/favorite_repository.dart';

class GetFavorites {
  final FavoriteRepository repository;

  GetFavorites(this.repository);

  Future<List<FavoriteProduct>> call() async {
    return await repository.getFavorites();
  }
}