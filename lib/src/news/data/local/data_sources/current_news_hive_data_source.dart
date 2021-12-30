import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/news/data/local/mappers/current_news_mapper.dart';
import 'package:karate_stars_app/src/news/data/local/models/current_news_db.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';

class CurrentNewsHiveDataSource extends CacheDataSource
    implements CacheableDataSource<CurrentNews> {
  final Box<CurrentNewsDB> _currentNewsBox;
  final _mapper = CurrentNewsMapper();

  CurrentNewsHiveDataSource(this._currentNewsBox, int maxCacheTime)
      : super(maxCacheTime);

  @override
  Future<List<CurrentNews>> getAll() async {
    final newsList = _currentNewsBox.values;

    return newsList.map((news) => _mapper.mapToDomain(news)).toList();
  }

  @override
  Future<void> save(List<CurrentNews> items) async {
    final newsDB = items.map((item) => _mapper.mapToDB(item)).toList();

    await _currentNewsBox.addAll(newsDB);
  }

  @override
  Future<bool> areValidValues() async {
    final data = _currentNewsBox.values.toList();
    return !super.areDirty(data);
  }

  @override
  Future<void> invalidate() async {
    _currentNewsBox.clear();
  }
}
