import 'package:hive_flutter/hive_flutter.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/event_types/data/local/event_type_db.dart';
import 'package:karate_stars_app/src/event_types/data/local/event_type_hive_data_source.dart';
import 'package:karate_stars_app/src/event_types/data/local/event_type_mapper.dart';
import 'package:karate_stars_app/src/event_types/domain/entities/event_type.dart';
import '../../../../common/mothers/event_types_mother.dart';
import '../../../common/data/local/common_local_data_source_test.dart';

Future<CacheableDataSource<EventType>> cacheFactory(
    Box<EventTypeDB> box, int millis) async {
  return EventTypeHiveDataSource(
      box, Duration(milliseconds: millis).inMilliseconds);
}

void main() {
  executeCacheTests(cacheFactory,
      [worldChampionships(), europeanChampionships()], EventTypeMapper());
}
