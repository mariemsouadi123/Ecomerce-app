import 'package:ecommerce_app/features/ecommerce/data/datasources/product_remote_data_source.dart';

import '../../domain/repositories/product_repository.dart';
import '../../domain/entities/product.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Product>> getProducts() async {
    return await remoteDataSource.getProducts();
  }
}