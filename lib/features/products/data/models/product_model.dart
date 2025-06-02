import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/product.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Product {
  const ProductModel({
   required String id,
    String? name,
    double? price,
    String? description,
    String? category,
    int? stock,
    String? imageUrl,
  }) : super(
          id: id,
          name: name ?? 'Nom inconnu', // Valeur par défaut
          price: price ?? 0.0,
          description: description ?? '',
          category: category ?? 'Autre',
          stock: stock ?? 0,
          imageUrl: imageUrl ?? 'https://via.placeholder.com/150',
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
  try {
    return _$ProductModelFromJson({
      'id': json['id'] ?? json['_id'] ?? '',
      'name': json['name'],
      'price': json['price'],
      'description': json['description'],
      'category': json['category'],
      'stock': json['stock'],
      'imageUrl': json['imageUrl'],
    });
  } catch (e) {
    throw FormatException('Failed to parse product: ${e.toString()}');
  }
}
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}