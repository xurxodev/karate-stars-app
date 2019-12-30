import 'package:karate_stars_app/src/common/data/local/data_sources.dart';
import 'package:karate_stars_app/src/common/data/remote/api_repository.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/news/data/parsers/current_news_parser.dart';
import 'package:karate_stars_app/src/news/domain/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';

class CurrentNewsCachedRepository extends ApiRepository implements CurrentNewsRepository {
  final CurrentNewsParser parser = CurrentNewsParser();
  final ReadableDataSource<CurrentNews> _readableDataSource;

  CurrentNewsCachedRepository(this._readableDataSource);

  @override
  Future<List<CurrentNews>> getCurrentNews(ReadPolicy readPolicy) async {
    return await _readableDataSource.getAll();
  }
}
