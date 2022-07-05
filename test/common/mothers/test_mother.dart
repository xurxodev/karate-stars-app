import '../../unit_tests/common/domain/entities/TestEntity.dart';

TestEntity testEntity1() {
  return TestEntity('A', 'TestEntity 1', '1', '2');
}

TestEntity testEntity2() {
  return TestEntity('B', 'TestEntity 1', '1', '2');
}

TestEntity testEntity3() {
  return TestEntity('C', 'TestEntity 1', '3', '4');
}

TestEntity testEntity4() {
  return TestEntity('D', 'TestEntity 1', '3', '4');
}

List<TestEntity> allRankingEntries() {
  return [testEntity1(), testEntity2(), testEntity3(), testEntity4()];
}
