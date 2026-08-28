import 'package:products_app/features/products/domain/entity/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.images,
    required super.title,
    required super.stock,
    required super.description,
    required super.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      images: (json['images'] as List?)?.cast<String>() ?? const [],
      title: json['title'] as String,
      stock: json['stock'] as int? ?? 0,
      description: json['description'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'images': images,
      'title': title,
      'stock': stock,
      'description': description,
      'price': price,
    };
  }
}
