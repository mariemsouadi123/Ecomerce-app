import 'package:dio/dio.dart';
import 'package:ecommerce_app/core/errors/failures.dart';
import 'package:ecommerce_app/core/network/dio_client.dart';
import 'package:ecommerce_app/features/products/data/models/product_model.dart';
import 'package:ecommerce_app/features/products/domain/entities/product.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> getProducts();
  Future<Product> getProduct(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioClient dioClient;

  ProductRemoteDataSourceImpl({required this.dioClient});

  @override
Future<List<Product>> getProducts() async {
  try {
    final response = await dioClient.dio.get('/products');
    
    if (response.data == null) {
      throw ServerFailure('La réponse API est vide');
    }

    return (response.data as List).map((json) {
      try {
        final id = json['id'] ?? json['_id'];
        if (id == null) {
          throw FormatException('Le produit est missing ID');
        }
        return ProductModel.fromJson({...json, 'id': id.toString()});
      } catch (e) {
        throw ServerFailure('Format de produit invalide: ${e.toString()}');
      }
    }).toList();
  } on DioException catch (e) {
    throw ServerFailure(e.message ?? 'Erreur de réseau');
  }
}
  
  @override
  Future<Product> getProduct(String id) {
    // TODO: implement getProduct
    throw UnimplementedError();
  }
}
