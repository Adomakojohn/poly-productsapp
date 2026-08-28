import 'package:flutter/material.dart';
import 'package:products_app/features/products/domain/entity/product.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Gallery(images: product.images),
          const SizedBox(height: 20),
          Text(product.title, style: theme.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              _StockBadge(stock: product.stock),
            ],
          ),
          const Divider(height: 32),
          Text('Description', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(product.description, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _Gallery extends StatelessWidget {
  const _Gallery({required this.images});

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const SizedBox(
        height: 220,
        child: Center(child: Icon(Icons.image_not_supported_outlined, size: 48)),
      );
    }
    return SizedBox(
      height: 220,
      child: PageView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) => ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            images[index],
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) =>
                const Center(child: Icon(Icons.broken_image_outlined, size: 48)),
          ),
        ),
      ),
    );
  }
}

class _StockBadge extends StatelessWidget {
  const _StockBadge({required this.stock});

  final int stock;

  @override
  Widget build(BuildContext context) {
    final inStock = stock > 0;
    final color = inStock ? Colors.green : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        inStock ? 'In stock ($stock)' : 'Out of stock',
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
