// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 1)
class CartItemModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final List<String> images;
  @HiveField(2)
  final String title;
  @HiveField(3)
  int itemCount;
  @HiveField(4)
  final int price;

  CartItemModel({
    required this.id,
    required this.images,
    required this.title,
    this.itemCount = 1,
    required this.price,
  });
}
