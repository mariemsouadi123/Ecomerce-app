import 'package:ecommerce_app/features/ecommerce/domain/entities/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = 'ecommerce.db';
  static const _databaseVersion = 1;

  // Singleton pattern
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        price REAL NOT NULL,
        description TEXT,
        category TEXT,
        image TEXT,
        rate REAL,
        count INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE cart_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id INTEGER NOT NULL,
        quantity INTEGER NOT NULL,
        FOREIGN KEY (product_id) REFERENCES products (id)
      )
    ''');


  }
  // Product operations
  Future<int> insertProduct(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('products', row);
  }

  Future<List<Map<String, dynamic>>> queryAllProducts() async {
    final db = await instance.database;
    return await db.query('products');
  }

  // Cart operations
  Future<int> insertCartItem(int productId) async {
    final db = await instance.database;

    // Check if product already exists in cart
    final existingItems = await db.query(
      'cart_items',
      where: 'product_id = ?',
      whereArgs: [productId],
    );

    if (existingItems.isNotEmpty) {
      // Update quantity if exists
      final currentQuantity = existingItems.first['quantity'] as int;
      return await db.update(
        'cart_items',
        {'quantity': currentQuantity + 1},
        where: 'product_id = ?',
        whereArgs: [productId],
      );
    } else {
      // Insert new item if doesn't exist
      return await db.insert('cart_items', {
        'product_id': productId,
        'quantity': 1,
      });
    }
  }

  Future<List<Map<String, dynamic>>> getCartItemsWithProducts() async {
    final db = await instance.database;
    return await db.rawQuery('''
      SELECT 
        cart_items.id as cart_item_id,
        cart_items.quantity,
        products.id as product_id,
        products.title,
        products.price,
        products.description,
        products.category,
        products.image,
        products.rate,
        products.count
      FROM cart_items
      INNER JOIN products ON cart_items.product_id = products.id
    ''');
  }

  Future<int> getCartItemsCount() async {
    final db = await instance.database;
    final result = await db.rawQuery('''
      SELECT SUM(quantity) as total FROM cart_items
    ''');
    return result.first['total'] as int? ?? 0;
  }

  Future<int> clearCart() async {
    final db = await instance.database;
    return await db.delete('cart_items');
  }
  Future<int> getCartItemCount(int productId) async {
  final db = await database;
  final result = await db.query(
    'cart_items',
    where: 'product_id = ?',
    whereArgs: [productId],
  );
  return result.isNotEmpty ? result.first['quantity'] as int : 0;
}

Future<int> updateCartItemQuantity(int productId, int newQuantity) async {
  final db = await database;
  return await db.update(
    'cart_items',
    {'quantity': newQuantity},
    where: 'product_id = ?',
    whereArgs: [productId],
  );
}
// Dans DatabaseHelper
Future<void> createFavoritesTable() async {
    final db = await database;
  await db.execute('''
    CREATE TABLE IF NOT EXISTS favorites (
      product_id INTEGER PRIMARY KEY,
      added_at TEXT NOT NULL,
      FOREIGN KEY (product_id) REFERENCES products(id)
    )
  ''');
}

Future<int> insertFavoriteProduct(Product product) async {
  final db = await database;
  return await db.insert('favorites', {
    'product_id': product.id,
    'added_at': DateTime.now().toIso8601String(),
  });
}

Future<int> removeFavoriteProduct(int productId) async {
  final db = await database;
  return await db.delete(
    'favorites',
    where: 'product_id = ?',
    whereArgs: [productId],
  );
}

Future<List<Map<String, dynamic>>> getFavoriteProducts() async {
  final db = await database;
  return await db.rawQuery('''
    SELECT p.*, f.added_at 
    FROM favorites f
    JOIN products p ON f.product_id = p.id
    ORDER BY f.added_at DESC
  ''');
}

Future<bool> isProductFavorite(int productId) async {
  final db = await database;
  final result = await db.query(
    'favorites',
    where: 'product_id = ?',
    whereArgs: [productId],
  );
  return result.isNotEmpty;
}

}