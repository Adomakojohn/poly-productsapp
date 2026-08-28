import 'package:dio/dio.dart';

final Dio dio = Dio();

void CreateDio() {
  dio.options.baseUrl = 'https://dummyjson.com/';
}
