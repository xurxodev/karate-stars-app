import 'package:hive_flutter/hive_flutter.dart';

import 'package:karate_stars_app/src/category_types/data/local/category_type_db.dart';
import 'package:karate_stars_app/src/category_types/data/local/category_type_hive_data_source.dart';
import 'package:karate_stars_app/src/category_types/data/local/category_type_mapper.dart';
import 'package:karate_stars_app/src/category_types/domain/entities/category_type.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';

import '../../../../common/mothers/category_types_mother.dart';
import '../../../common/data/local/common_local_data_source_test.dart';

Future<CacheableDataSource<CategoryType>> cacheFactory(
    Box<CategoryTypeDB> box, int millis) async {
  return CategoryTypeHiveDataSource(
      box, Duration(milliseconds: millis).inMilliseconds);
}

void main() {
  executeCacheTests(
      cacheFactory, [kata(), kumite()], CategoryTypeMapper());
}
