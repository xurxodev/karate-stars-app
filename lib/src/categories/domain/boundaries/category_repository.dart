import 'package:karate_stars_app/src/categories/domain/entities/category.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';

abstract class CategoryRepository {
  Future<List<Category>> getAll(ReadPolicy readPolicy);
}
