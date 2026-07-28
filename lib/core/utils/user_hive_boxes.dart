import 'package:e_commerce_app/core/utils/app_constants.dart';
import 'package:e_commerce_app/core/utils/shared_preferences.dart';
import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';
import 'package:e_commerce_app/features/home/data/model/product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class UserHiveBoxes {
  static Future<Box<ProductModel>> favoritesBox() async {
    final boxName = await _userBoxName(AppConstants.favoritesBox);
    return _openBox<ProductModel>(boxName);
  }

  static Future<Box<CartItemModel>> cartBox() async {
    final boxName = await _userBoxName(AppConstants.cartBox);
    return _openBox<CartItemModel>(boxName);
  }

  static Future<void> openCurrentUserBoxes() async {
    await favoritesBox();
    await cartBox();
  }

  static Future<Box<T>> _openBox<T>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<T>(boxName);
    }
    return Hive.openBox<T>(boxName);
  }

  static Future<String> _userBoxName(String baseName) async {
    final userId = await FlutterSharedPreferences.instance.getUserId();
    final normalizedUserId = userId.trim().isEmpty ? 'guest' : userId.trim();
    return '${baseName}_$normalizedUserId';
  }
}
