import 'package:hive_flutter/hive_flutter.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';

@HiveType(typeId: 999)
class TestModelDB extends HiveObject implements CacheablePartialModelDB {
  @override
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String relatedId1;

  @HiveField(3)
  final String relatedId2;

  @override
  @HiveField(4)
  final String lastUpdate;

  TestModelDB(
      this.id, this.name, this.relatedId1, this.relatedId2, this.lastUpdate);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'relatedId1': relatedId1,
      'relatedId2': relatedId2
    };
  }
}
