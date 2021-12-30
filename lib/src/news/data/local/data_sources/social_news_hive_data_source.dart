import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/news/data/local/mappers/social_news_mapper.dart';
import 'package:karate_stars_app/src/news/data/local/models/social_news_db.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';

class SocialNewsHiveDataSource extends CacheDataSource
    implements CacheableDataSource<SocialNews> {
  final Box<SocialNewsDB> _socialNewsBox;
  final _mapper = SocialNewsMapper();

  SocialNewsHiveDataSource(
      this._socialNewsBox, int maxCacheTime)
      : super(maxCacheTime);

  @override
  Future<List<SocialNews>> getAll() async {
    final newsList = _socialNewsBox.values;

    return newsList.map((news) => _mapper.mapToDomain(news)).toList();
  }

  @override
  Future<void> save(List<SocialNews> items) async {
    final newsDB = items.map((item) => _mapper.mapToDB(item)).toList();

    _socialNewsBox.addAll(newsDB);
  }

  @override
  Future<bool> areValidValues() async {
    final data = _socialNewsBox.values.toList();
    return !super.areDirty(data);
  }

  @override
  Future<void> invalidate() async {
    _socialNewsBox.clear();
  }
}