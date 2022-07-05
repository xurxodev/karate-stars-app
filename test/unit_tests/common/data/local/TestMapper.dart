import 'package:karate_stars_app/src/common/data/local/DataBaseMapper.dart';
import '../../domain/entities/TestEntity.dart';
import 'TestModelDB.dart';

class TestMapper implements DataBaseMapper<TestEntity, TestModelDB> {
  @override
  TestEntity mapToDomain(TestModelDB modelDB) {
    return TestEntity(
        modelDB.id, modelDB.name, modelDB.relatedId1, modelDB.relatedId2);
  }

  @override
  TestModelDB mapToDB(TestEntity entity) {
    return TestModelDB(
      entity.id,
      entity.name,
      entity.relatedId1,
      entity.relatedId2,
      DateTime.now().toIso8601String(),
    );
  }
}
