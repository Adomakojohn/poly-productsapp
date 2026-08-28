import 'package:dio/dio.dart';

Dio createDio() => Dio(
  BaseOptions(
    baseUrl: 'https://dummyjson.com/',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ),
);
