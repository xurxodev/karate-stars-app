import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/news/data/parsers/current_news_parser.dart';
import 'package:karate_stars_app/src/news/domain/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';

class CurrentNewsCachedRepository implements CurrentNewsRepository {
  final CurrentNewsParser parser = CurrentNewsParser();
  final ReadableDataSource<CurrentNews> _remoteDataSource;
  final CacheDataSource<CurrentNews> _cacheDataSource;

  CurrentNewsCachedRepository(this._remoteDataSource, this._cacheDataSource);

  @override
  Future<List<CurrentNews>> getCurrentNews(ReadPolicy readPolicy) async {
    final currentNewsList =  await _remoteDataSource.getAll();

    final cacheNewsList = await _cacheDataSource.getAll();

    _cacheDataSource.save(currentNewsList);

    return cacheNewsList;
  }
}
