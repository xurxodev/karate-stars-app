import 'package:karate_stars_app/src/categories/domain/boundaries/category_repository.dart';
import 'package:karate_stars_app/src/categories/domain/entities/category.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';

class GetCategoriesUseCase {
  final CategoryRepository _categoryRepository;

  GetCategoriesUseCase(this._categoryRepository);

  Future<List<Category>> execute(ReadPolicy readPolicy) async {
    final data = await _categoryRepository.getAll(readPolicy);

    data.sort((a, b) => a.name.compareTo(b.name));

    return data;
  }
}
