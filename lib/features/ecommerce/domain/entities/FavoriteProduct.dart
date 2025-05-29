import 'package:ecommerce_app/features/ecommerce/domain/entities/product.dart';

class FavoriteProduct {
  final Product product;
  final DateTime addedAt;

  FavoriteProduct({
    required this.product,
    required this.addedAt,
  });
}