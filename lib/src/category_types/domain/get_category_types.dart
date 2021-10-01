import 'package:karate_stars_app/src/category_types/domain/boundaries/category_type_repository.dart';
import 'package:karate_stars_app/src/category_types/domain/entities/category_type.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';

class GetCategoryTypesUseCase {
  final CategoryTypeRepository _categoryTypeRepository;

  GetCategoryTypesUseCase(this._categoryTypeRepository);

  Future<List<CategoryType>> execute(ReadPolicy readPolicy) async {
    final data = await _categoryTypeRepository.getAll(readPolicy);

    data.sort((a, b) => a.name.compareTo(b.name));

    return data;
  }
}
