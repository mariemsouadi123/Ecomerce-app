import '../repositories/cart_repository.dart';
import '../entities/product.dart';

class AddToCart {
  final CartRepository repository;

  AddToCart(this.repository);

  Future<void> call(Product product) async {
    return await repository.addToCart(product);
  }
}