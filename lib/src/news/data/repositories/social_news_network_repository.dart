import 'dart:convert';

import 'package:karate_stars_app/src/common/data/api_repository.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/news/data/parsers/social_news_parser.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/domain/social_news_repository.dart';

class SocialNewsNetworkRepository extends ApiRepository implements SocialNewsRepository {
  SocialNewsParser parser = SocialNewsParser();

  @override
  Future<List<SocialNews>> getSocialNews(ReadPolicy readPolicy) async {
    return await _fetchSocialNews();
  }

  Future<List<SocialNews>> _fetchSocialNews() async {
    final response = await super.get('/socialnews');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return parser.parse(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
