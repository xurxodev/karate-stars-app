import 'package:karate_stars_app/src/common/data/cached_repository.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/news/data/parsers/current_news_parser.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';

class CurrentNewsCachedRepository extends CachedRepository<CurrentNews>
    implements CurrentNewsRepository {
  final CurrentNewsParser parser = CurrentNewsParser();

  CurrentNewsCachedRepository(CacheableDataSource<CurrentNews> cacheDataSource,
      ReadableDataSource<CurrentNews> remoteDataSource)
      : super(cacheDataSource, remoteDataSource);
}
