import 'dart:convert';

import 'package:karate_stars_app/src/common/auth/api_credentials_loader.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/remote/api_data_source.dart';
import 'package:karate_stars_app/src/common/data/remote/token_storage.dart';
import 'package:karate_stars_app/src/news/data/parsers/social_news_parser.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';

class SocialNewsApiDataSource extends ApiDataSource
    implements ReadableDataSource<SocialNews> {
  SocialNewsParser parser = SocialNewsParser();

  SocialNewsApiDataSource(String baseAddress, Credentials apiCredentials,
      ApiTokenStorage apiTokenStorage)
      : super(baseAddress, apiCredentials, apiTokenStorage);

  @override
  Future<List<SocialNews>> getAll() async {
    return await _fetchSocialNews();
  }

  Future<List<SocialNews>> _fetchSocialNews() async {
    final response = await super.get('/socialnews');

    try {
      return parser.parse(json.decode(response.body));
    } on Exception {
      print(response.body);
      rethrow;
    }
  }
}
