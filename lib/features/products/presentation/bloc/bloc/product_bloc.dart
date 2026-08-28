import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:products_app/core/error/failure.dart';
import 'package:products_app/features/products/domain/entity/product.dart';
import 'package:products_app/features/products/domain/repository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;

  ProductBloc(this.repository) : super(const ProductInitial()) {
    on<ProductsRequested>(_onRequested);
  }

  Future<void> _onRequested(
    ProductsRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductsLoading());

    try {
      final products = await repository.getProducts();
      emit(ProductsLoaded(products));
    } on Failure catch (f) {
      emit(ProductsError(f.message));
    }
  }
}
