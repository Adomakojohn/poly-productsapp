import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_app/core/network/dio_client.dart';
import 'package:products_app/core/theme/app_theme.dart';
import 'package:products_app/features/products/data/datasource/product_remote_data_source.dart';
import 'package:products_app/features/products/data/repository/product_repository_impl.dart';
import 'package:products_app/features/products/presentation/bloc/bloc/product_bloc.dart';
import 'package:products_app/features/products/presentation/screens/product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Products',
      theme: AppTheme.light,
      home: BlocProvider(
        create: (_) => ProductBloc(
          ProductRepositoryImpl(ProductRemoteDataSource(createDio())),
        )..add(const ProductsRequested()),
        child: const ProductScreen(),
      ),
    );
  }
}
