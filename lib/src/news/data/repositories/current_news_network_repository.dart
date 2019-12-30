import 'dart:convert';

import 'package:karate_stars_app/src/common/data/api_repository.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/news/data/parsers/current_news_parser.dart';
import 'package:karate_stars_app/src/news/domain/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';

class CurrentNewsNetworkRepository extends ApiRepository implements CurrentNewsRepository {
  CurrentNewsParser parser = CurrentNewsParser();

  @override
  Future<List<CurrentNews>> getCurrentNews(ReadPolicy readPolicy) async {
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
