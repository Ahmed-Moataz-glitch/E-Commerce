import 'package:e_commerce_app/core/views/widgets/api_result.dart';
import 'package:e_commerce_app/features/home/domain/entities/categories_response_entity.dart';
import 'package:e_commerce_app/features/home/domain/repo/repo/home_repo.dart';

class GetCategoriesUseCase {
  final HomeRepo _homeRepo;
  GetCategoriesUseCase(this._homeRepo);

  Future<ApiResult<List<CategoriesResponseEntity>>> call() {
    return _homeRepo.getCategories();
  }
}