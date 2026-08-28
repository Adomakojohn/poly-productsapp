import 'package:equatable/equatable.dart';

class Product extends Equatable {
  //id
  //price
  //stock status
  //name
  //details

  final int id;
  final double price;
  final int stock;
  final String title;
  final String description;
  final String images;

  const Product({
    required this.id,
    required this.images,
    required this.price,
    required this.stock,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [id, price, stock, title, description, images];
}
