import 'package:products_app/features/products/domain/entity/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}
