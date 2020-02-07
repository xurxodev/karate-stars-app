import 'dart:convert';


import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/remote/api_data_source.dart';
import 'package:karate_stars_app/src/common/data/remote/token_storage.dart';
import 'package:karate_stars_app/src/news/data/parsers/current_news_parser.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';

class CurrentNewsApiDataSource extends ApiDataSource
    implements ReadableDataSource<CurrentNews> {
  CurrentNewsParser parser = CurrentNewsParser();

  CurrentNewsApiDataSource(ApiTokenStorage apiTokenStorage) : super(apiTokenStorage);

  @override
  Future<List<CurrentNews>> getAll() async {
    return await _fetchCurrentNews();
  }

  Future<List<CurrentNews>> _fetchCurrentNews() async {
    final response = await super.get('/currentnews');

    // If server returns an OK response, parse the JSON.
    return parser.parse(json.decode(response.body));
  }
}
