import 'package:karate_stars_app/src/categories/data/local/category_db.dart';
import 'package:karate_stars_app/src/categories/domain/entities/category.dart'
    as category_entity;
import 'package:karate_stars_app/src/common/data/local/DataBaseMapper.dart';

class CategoryMapper
    implements DataBaseMapper<category_entity.Category, CategoryDB> {
  @override
  category_entity.Category mapToDomain(CategoryDB modelDB) {
    return category_entity.Category(modelDB.id, modelDB.name, modelDB.typeId,
        modelDB.main, modelDB.paraKarate);
  }

  @override
  CategoryDB mapToDB(category_entity.Category entity) {
    return CategoryDB(entity.id, entity.name, entity.typeId,
        DateTime.now().toIso8601String(), entity.main, entity.paraKarate);
  }
}
