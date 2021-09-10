import 'package:karate_stars_app/src/common/data/cached_repository.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/news/data/parsers/social_news_parser.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/social_news_repository.dart';

class SocialNewsCachedRepository extends CachedRepository<SocialNews>
    implements SocialNewsRepository {
  final SocialNewsParser parser = SocialNewsParser();

  SocialNewsCachedRepository(CacheableDataSource<SocialNews> cacheDataSource,
      ReadableDataSource<SocialNews> remoteDataSource)
      : super(cacheDataSource, remoteDataSource);
}
