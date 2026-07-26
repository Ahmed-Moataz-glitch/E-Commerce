import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/home/data/model/product_model.dart';
import 'package:e_commerce_app/features/home/domain/entities/categories_response_entity.dart';
import 'package:e_commerce_app/features/home/domain/entities/products_response_entity.dart';
import 'package:e_commerce_app/features/home/domain/repo/data_source/home_data_source.dart';
import 'package:e_commerce_app/features/home/domain/repo/repo/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeDataSource _homeDataSource;
  HomeRepoImpl(this._homeDataSource);

  @override
  Future<ApiResult<List<CategoriesResponseEntity>>> getCategories() async {
    return await _homeDataSource.getCategories();
  }

  @override
  Future<ApiResult<List<ProductsResponseEntity>>> getProducts() async {
    return await _homeDataSource.getProducts();
  }

  @override
  ProductModel? getSavedProduct(int productId) {
    return _homeDataSource.getSavedProduct(productId);
  }

  @override
  Future<void> saveProduct(ProductModel product) async {
    return await _homeDataSource.saveProduct(product);
  }
  
  @override
  Future<void> deleteProduct(int productId) async {
    return await _homeDataSource.deleteProduct(productId);
  }
}