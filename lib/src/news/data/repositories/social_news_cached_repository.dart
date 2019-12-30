import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/news/data/parsers/social_news_parser.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/domain/social_news_repository.dart';

class SocialNewsCachedRepository implements SocialNewsRepository {
  final SocialNewsParser parser = SocialNewsParser();
  final ReadableDataSource<SocialNews> _readableDataSource;

  SocialNewsCachedRepository(this._readableDataSource);

  @override
  Future<List<SocialNews>> getSocialNews(ReadPolicy readPolicy) async {
    return await _readableDataSource.getAll();
  }
}
