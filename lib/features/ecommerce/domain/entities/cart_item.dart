import 'package:ecommerce_app/features/ecommerce/domain/entities/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({required this.product, required this.quantity, required int id});

}