import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/home/domain/entities/categories_response_entity.dart';
import 'package:e_commerce_app/features/home/domain/entities/products_response_entity.dart';

abstract class HomeRepo {
  Future<ApiResult<List<ProductsResponseEntity>>> getProducts();

  Future<ApiResult<List<CategoriesResponseEntity>>> getCategories();
}