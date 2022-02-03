import 'package:hive_flutter/hive_flutter.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/videos/data/local/models/video_db.dart';
import 'package:karate_stars_app/src/videos/data/local/video_hive_data_source.dart';
import 'package:karate_stars_app/src/videos/data/local/video_mapper.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';
import '../../../../common/mothers/videos_mother.dart';
import '../../../common/data/local/common_local_data_source_test.dart';

Future<CacheableDataSource<Video>> cacheFactory(
    Box<VideoDB> box, int millis) async {
  return VideoHiveDataSource(
      box, Duration(milliseconds: millis).inMilliseconds);
}

void main() {
  executeCacheTests(
      cacheFactory, [sandraTokyo2020(), ryoKiyuna2020()], VideoMapper());
}
