import '../repositories/cart_repository.dart';

class GetCartItemsCount {
  final CartRepository repository;

  GetCartItemsCount(this.repository);

  Future<int> call() async {
    return await repository.getCartItemsCount();
  }
}