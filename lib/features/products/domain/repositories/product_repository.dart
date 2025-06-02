import '../../../../core/errors/failures.dart';
import '../../domain/entities/product.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts();
  // Future<Either<Failure, Product>> getProduct(String id);
}