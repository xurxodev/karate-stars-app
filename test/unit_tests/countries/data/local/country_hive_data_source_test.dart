import 'package:hive_flutter/hive_flutter.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/countries/data/local/country_db.dart';
import 'package:karate_stars_app/src/countries/data/local/country_hive_data_source.dart';
import 'package:karate_stars_app/src/countries/data/local/country_mapper.dart';
import 'package:karate_stars_app/src/countries/domain/entities/country.dart';
import '../../../../common/mothers/countries_mother.dart';
import '../../../common/data/local/common_local_data_source_test.dart';

Future<CacheableDataSource<Country>> cacheFactory(
    Box<CountryDB> box, int millis) async {
  return CountryHiveDataSource(
      box, Duration(milliseconds: millis).inMilliseconds);
}

void main() {
  executeCacheTests(cacheFactory, [spain(), croatia(), austria(), azerbaijan()],
      CountryMapper());
}
