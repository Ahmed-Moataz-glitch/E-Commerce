// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final int price;
  @HiveField(4)
  final bool isFavorite;
  
  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.isFavorite,
  });

  ProductModel copyWith({
    int? id,
    String? title,
    String? description,
    int? price,
    bool? isFavorite,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
