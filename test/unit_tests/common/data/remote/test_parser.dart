import 'package:karate_stars_app/src/rankings/data/remote/ranking_entry_parser.dart';

import '../../domain/entities/TestEntity.dart';

class TestParser implements Parser<TestEntity> {
  @override
  List<TestEntity> parse(List<dynamic> json) {
    return json.map((jsonItem) => _parseEntity(jsonItem)).toList();
  }

  TestEntity _parseEntity(Map<String, dynamic> jsonData) {
    print(jsonData);
    return TestEntity(jsonData['id'], jsonData['name'], jsonData['relatedId1'],
        jsonData['relatedId2']);
  }
}
