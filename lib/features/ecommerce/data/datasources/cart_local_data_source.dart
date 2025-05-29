import 'package:ecommerce_app/features/ecommerce/data/datasources/database_helper.dart';
import 'package:ecommerce_app/features/ecommerce/domain/entities/cart_item.dart';
import 'package:ecommerce_app/features/ecommerce/domain/entities/product.dart';

abstract class CartLocalDataSource {
  Future<void> addToCart(Product product);
  Future<List<CartItem>> getCartItems();
  Future<int> getCartItemsCount();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final DatabaseHelper databaseHelper;

  CartLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<void> addToCart(Product product) async {
    // Vérifie si le produit existe déjà dans le panier
    final existingItems = await databaseHelper.getCartItemCount(product.id);
    
    if (existingItems > 0) {
      // Si le produit existe, met à jour la quantité
      await databaseHelper.updateCartItemQuantity(
        product.id, 
        existingItems + 1
      );
    } else {
      // Sinon, ajoute un nouvel élément
      await databaseHelper.insertCartItem(product.id);
    }
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    final items = await databaseHelper.getCartItemsWithProducts();
    return items.map((item) => CartItem(
        id: item['cart_item_id'] as int,
        product: Product(
        id: item['product_id'] as int,
        title: item['title'] as String,
        price: item['price'] as double,
        description: item['description'] as String,
        category: item['category'] as String,
        image: item['image'] as String,
        rating: Rating(
          rate: item['rate'] as double,
          count: item['count'] as int,
        ),
      ),
      quantity: item['quantity'] as int,
    )).toList();
  }



  @override
  Future<int> getCartItemsCount() async {
    return await databaseHelper.getCartItemsCount();
  }
}