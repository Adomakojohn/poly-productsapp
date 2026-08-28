import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_app/core/widgets/app_empty_view.dart';
import 'package:products_app/core/widgets/app_error_view.dart';
import 'package:products_app/core/widgets/app_loading_view.dart';
import 'package:products_app/features/products/domain/entity/product.dart';
import 'package:products_app/features/products/presentation/bloc/bloc/product_bloc.dart';
import 'package:products_app/features/products/presentation/screens/product_details_screen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          void reload() =>
              context.read<ProductBloc>().add(const ProductsRequested());

          return switch (state) {
            ProductInitial() || ProductsLoading() => const AppLoadingView(
              message: 'Loading products...',
            ),
            ProductsError(:final message) => AppErrorView(
              message: message,
              onRetry: reload,
            ),
            ProductsLoaded(:final products) when products.isEmpty =>
              AppEmptyView(
                message: 'No products found',
                icon: Icons.inventory_2_outlined,
                actionLabel: 'Refresh',
                onAction: reload,
              ),
            ProductsLoaded(:final products) => _ProductList(products: products),
          };
        },
      ),
    );
  }
}

class _ProductList extends StatelessWidget {
  const _ProductList({required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async =>
          context.read<ProductBloc>().add(const ProductsRequested()),
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: products.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, index) => _ProductTile(product: products[index]),
      ),
    );
  }
}

class _ProductTile extends StatelessWidget {
  const _ProductTile({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: _Thumbnail(url: product.images.firstOrNull),
        title: Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => ProductDetailsScreen(product: product),
          ),
        ),
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    const size = 56.0;
    if (url == null) {
      return const SizedBox(
        width: size,
        height: size,
        child: Icon(Icons.image_not_supported_outlined),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        url!,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => const SizedBox(
          width: size,
          height: size,
          child: Icon(Icons.broken_image_outlined),
        ),
      ),
    );
  }
}
