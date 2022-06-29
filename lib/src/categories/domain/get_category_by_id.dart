import 'package:karate_stars_app/src/categories/domain/boundaries/category_repository.dart';
import 'package:karate_stars_app/src/categories/domain/entities/category.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';

class GetCategoryByIdUseCase {
  final CategoryRepository _categoryRepository;

  GetCategoryByIdUseCase(this._categoryRepository);

  Future<Category> execute(ReadPolicy readPolicy, String categoryId) async {
    final allCategories = await _categoryRepository.getAll(readPolicy);

    return allCategories.firstWhere((cat) => cat.id == categoryId);
  }
}
