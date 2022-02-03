import 'package:karate_stars_app/src/category_types/data/local/category_type_db.dart';
import 'package:karate_stars_app/src/category_types/domain/entities/category_type.dart';
import 'package:karate_stars_app/src/common/data/local/DataBaseMapper.dart';

class CategoryTypeMapper
    implements DataBaseMapper<CategoryType, CategoryTypeDB> {
  @override
  CategoryType mapToDomain(CategoryTypeDB modelDB) {
    return CategoryType(modelDB.id, modelDB.name);
  }

  @override
  CategoryTypeDB mapToDB(CategoryType entity) {
    return CategoryTypeDB(
      entity.id,
      entity.name,
      DateTime.now().toIso8601String(),
    );
  }
}
