import 'package:karate_stars_app/src/category_types/domain/entities/category_type.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';

abstract class CategoryTypeRepository {
  Future<List<CategoryType>> getAll(ReadPolicy readPolicy);
}
