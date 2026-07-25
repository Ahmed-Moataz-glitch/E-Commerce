import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/home/data/api/home_api.dart';
import 'package:e_commerce_app/features/home/data/model/categories_response_dto.dart';
import 'package:e_commerce_app/features/home/data/model/products_response_dto.dart';
import 'package:e_commerce_app/features/home/domain/entities/categories_response_entity.dart';
import 'package:e_commerce_app/features/home/domain/entities/products_response_entity.dart';
import 'package:e_commerce_app/features/home/domain/repo/data_source/home_data_source.dart';

class HomeDataSourceImpl extends HomeDataSource {
  final HomeApi _homeApi;
  HomeDataSourceImpl(this._homeApi);

  @override
  Future<ApiResult<List<CategoriesResponseEntity>>> getCategories() async {
    final result = await _homeApi.getCategories();
    switch (result) {
      case ApiSuccess<List<CategoriesResponseDto>>():
        return ApiSuccess<List<CategoriesResponseEntity>>(
          result.data?.map((dto) => dto.toEntity()).toList()
        );
      case ApiError<List<CategoriesResponseDto>>():
        return ApiError<List<CategoriesResponseEntity>>(result.message);
    }
  }

  @override
  Future<ApiResult<List<ProductsResponseEntity>>> getProducts() async {
    final result = await _homeApi.getProducts();
    switch (result) {
      case ApiSuccess<List<ProductsResponseDto>>():
        return ApiSuccess<List<ProductsResponseEntity>>(
          result.data?.map((dto) => dto.toEntity()).toList()
        );
      case ApiError<List<ProductsResponseDto>>():
        return ApiError<List<ProductsResponseEntity>>(result.message);
    }
  }
}
