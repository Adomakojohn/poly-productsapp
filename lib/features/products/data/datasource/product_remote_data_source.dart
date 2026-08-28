import 'package:dio/dio.dart';
import 'package:products_app/features/core/error/failure.dart';
import 'package:products_app/features/products/data/models/product_model.dart';

class ProductRemoteDataSource {
  final Dio dio;
  ProductRemoteDataSource(this.dio);

  Future<List<ProductModel>> getProducts() async {
    try {
      final res = await dio.get('/products', queryParameters: {'limit': 5});
      final list = res.data['products'] as List;

      return list.map((json) => ProductModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handle(e);
    }
  }

  Failure _handle(DioException e) {
    if (e.response == null) return const NetworkFailure();
    return ServerFailure('Request failed (${e.response!.statusCode})');
  }
}
