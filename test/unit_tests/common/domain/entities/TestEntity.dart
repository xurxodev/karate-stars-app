import 'package:karate_stars_app/src/common/domain/types.dart';

class TestEntity implements Identifiable {
  @override
  final String id;
  final String name;
  final String relatedId1;
  final String relatedId2;

  TestEntity(this.id, this.name, this.relatedId1, this.relatedId2);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          relatedId1 == other.relatedId1 &&
          relatedId2 == other.relatedId2;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ relatedId1.hashCode ^ relatedId2.hashCode;
}
