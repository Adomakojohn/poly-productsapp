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
      id: json['id'],
      images: json['images'],
      title: json['title'],
      stock: json['stock'],
      description: json['description'],
      price: json['price'],
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
