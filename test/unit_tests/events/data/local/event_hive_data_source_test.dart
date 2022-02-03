import 'package:hive_flutter/hive_flutter.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/events/data/local/event_db.dart';
import 'package:karate_stars_app/src/events/data/local/event_hive_data_source.dart';
import 'package:karate_stars_app/src/events/data/local/event_mapper.dart';
import 'package:karate_stars_app/src/events/domain/entities/event.dart';
import '../../../../common/mothers/events_mother.dart';
import '../../../common/data/local/common_local_data_source_test.dart';

Future<CacheableDataSource<Event>> cacheFactory(
    Box<EventDB> box, int millis) async {
  return EventHiveDataSource(
      box, Duration(milliseconds: millis).inMilliseconds);
}

void main() {
  executeCacheTests(cacheFactory,
      [europeanChampionships2021(), olympicGames2020()], EventMapper());
}
