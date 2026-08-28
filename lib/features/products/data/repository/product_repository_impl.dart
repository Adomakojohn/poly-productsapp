import 'package:products_app/features/products/data/datasource/product_remote_data_source.dart';
import 'package:products_app/features/products/domain/entity/product.dart';
import 'package:products_app/features/products/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Product>> getProducts() {
    return remoteDataSource.getProducts();
  }
}
