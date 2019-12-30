import 'dart:convert';


import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/remote/api_data_source.dart';
import 'package:karate_stars_app/src/news/data/parsers/current_news_parser.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';

class CurrentNewsApiDataSource extends ApiDataSource
    implements ReadableDataSource<CurrentNews> {
  CurrentNewsParser parser = CurrentNewsParser();

  @override
  Future<List<CurrentNews>> getAll() async {
    return await _fetchSocialNews();
  }

  Future<List<CurrentNews>> _fetchSocialNews() async {
    final response = await super.get('/currentnews');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return parser.parse(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
