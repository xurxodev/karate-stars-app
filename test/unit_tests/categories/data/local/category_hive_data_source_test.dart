import 'package:hive_flutter/hive_flutter.dart';
import 'package:karate_stars_app/src/categories/data/local/category_db.dart';
import 'package:karate_stars_app/src/categories/data/local/category_hive_data_source.dart';
import 'package:karate_stars_app/src/categories/data/local/category_mapper.dart';
import 'package:karate_stars_app/src/categories/domain/entities/category.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';

import '../../../../common/mothers/categories_mother.dart';
import '../../../common/data/local/common_local_data_source_test.dart';

Future<CacheableDataSource<Category>> cacheFactory(
    Box<CategoryDB> box, int millis) async {
  return CategoryHiveDataSource(
      box, Duration(milliseconds: millis).inMilliseconds);
}

void main() {
  executeCacheTests(
      cacheFactory, [maleKata(), maleTeamKumite(), femaleKata(), femaleTeamKumite()], CategoryMapper());
}
