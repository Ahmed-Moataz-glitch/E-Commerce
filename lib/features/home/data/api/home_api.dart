import 'dart:convert';

import 'package:e_commerce_app/core/utils/app_api.dart';
import 'package:e_commerce_app/core/utils/app_constants.dart';
import 'package:e_commerce_app/features/home/data/model/cart_item_model.dart';
import 'package:e_commerce_app/features/home/data/model/categories_response_dto.dart';
import 'package:e_commerce_app/features/home/data/model/product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/home/data/model/products_response_dto.dart';

class HomeApi {
  Future<ApiResult<List<ProductsResponseDto>>> getProducts() async {
    final url = Uri.https(AppApi.baseUrl, AppApi.productsEndpoint);
    try {
      var response = await http.get(url);
      if (response.statusCode != 200) {
        return ApiError<List<ProductsResponseDto>>('Failed to fetch products');
      } else {
        final responseBody = response.body;
        final json = jsonDecode(responseBody);
        final products = (json as List)
            .map((json) => ProductsResponseDto.fromJson(json))
            .toList();
        return ApiSuccess<List<ProductsResponseDto>>(products);
      }
    } catch (e) {
      return ApiError<List<ProductsResponseDto>>(e.toString());
    }
  }

  Future<ApiResult<List<CategoriesResponseDto>>> getCategories() async {
    final url = Uri.https(AppApi.baseUrl, AppApi.categoriesEndpoint);
    try {
      var response = await http.get(url);
      if (response.statusCode != 200) {
        return ApiError<List<CategoriesResponseDto>>(
          'Failed to fetch categories',
        );
      } else {
        final responseBody = response.body;
        final json = jsonDecode(responseBody);
        final categories = (json as List)
            .map((json) => CategoriesResponseDto.fromJson(json))
            .toList();
        return ApiSuccess<List<CategoriesResponseDto>>(categories);
      }
    } catch (e) {
      return ApiError<List<CategoriesResponseDto>>(e.toString());
    }
  }

  Future<void> saveProduct(ProductModel product) async {
    final box = Hive.box<ProductModel>(AppConstants.favoritesBox);
    await box.put(product.id, product);
  }

  ProductModel? getSavedProduct(int productId) {
    final box = Hive.box<ProductModel>(AppConstants.favoritesBox);
    return box.get(productId);
  }

  Future<void> deleteProduct(int productId) async {
    final box = Hive.box<ProductModel>(AppConstants.favoritesBox);
    await box.delete(productId);
  }

  Future<void> addProductToCart(CartItemModel product) async {
    final box = Hive.box<CartItemModel>(AppConstants.cartBox);
    await box.put(product.id, product);
  }

  CartItemModel? getProductFromCart(int productId) {
    final box = Hive.box<CartItemModel>(AppConstants.cartBox);
    return box.get(productId);
  }
}
