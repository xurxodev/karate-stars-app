import 'package:karate_stars_app/src/common/data/cached_repository.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/news/data/parsers/social_news_parser.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/domain/social_news_repository.dart';

class SocialNewsCachedRepository extends CachedRepository<SocialNews>
    implements SocialNewsRepository {
  final SocialNewsParser parser = SocialNewsParser();

  SocialNewsCachedRepository(CacheableDataSource<SocialNews> cacheDataSource,
      ReadableDataSource<SocialNews> remoteDataSource)
      : super(cacheDataSource, remoteDataSource);

  @override
  Future<List<SocialNews>> getSocialNews(ReadPolicy readPolicy) async {
    return super.getAll(readPolicy);
  }
}
