
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/news/data/local/current_news_daos.dart';
import 'package:karate_stars_app/src/news/data/local/current_news_mapper.dart';
import 'package:karate_stars_app/src/news/data/local/current_news_models.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';

class CurrentNewsFloorDataSource implements CacheDataSource<CurrentNews> {
  final CurrentNewsDao _currentNewsDao;
  final CurrentNewsSourcesDao _currentNewsSourcesDao;
  final _mapper = CurrentNewsMapper();

  CurrentNewsFloorDataSource(this._currentNewsDao, this._currentNewsSourcesDao);

  @override
  Future<List<CurrentNews>> getAll() async {
    final sources = await _currentNewsSourcesDao.findAll();
    final newsList = await _currentNewsDao.findAll();

    return newsList.map((news) {
      final source = sources.firstWhere((src) => src.id == news.sourceId);

      return _mapper.mapNewsToDomain(news, source);
    }).toList();
  }

  @override
  Future<void> save(List<CurrentNews> items) async {
    final sourcesDBToSave =
        items.map((item) => _mapper.mapSourceToDB(item.source)).toList();

    _currentNewsSourcesDao.insert(sourcesDBToSave);

    final sourcesDB = await _currentNewsSourcesDao.findAll();

    final newsDB = items.map((item) {
      final CurrentNewsSourceDB sourceDB =
          sourcesDB.firstWhere((src) => src.url == item.source.url);
      return _mapper.mapNewsToDB(item, sourceDB.id);
    }).toList();

    _currentNewsDao.insert(newsDB);
  }

  @override
  bool areValidValues() {
    return false;
  }

  @override
  void invalidate() {

  }
}
