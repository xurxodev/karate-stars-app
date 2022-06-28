import 'package:karate_stars_app/src/categories/domain/boundaries/category_repository.dart';
import 'package:karate_stars_app/src/categories/domain/entities/category.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';

class GetCategoriesByIdsUseCase {
  final CategoryRepository _categoryRepository;

  GetCategoriesByIdsUseCase(this._categoryRepository);

  Future<List<Category>> execute(
      ReadPolicy readPolicy, List<String> ids) async {
    final allCategories = await _categoryRepository.getAll(readPolicy);

    final categories =
        allCategories.where((cat) => ids.contains(cat.id)).toList();

    categories.sort((a, b) => a.name.compareTo(b.name));

    return categories;
  }
}
