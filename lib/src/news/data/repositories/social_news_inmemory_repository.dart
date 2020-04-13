import 'dart:convert';

import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/news/data/parsers/social_news_parser.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/social_news_repository.dart';
import 'package:flutter/services.dart' show rootBundle;

class SocialNewsInMemoryRepository implements SocialNewsRepository {
  final SocialNewsParser _parser = SocialNewsParser();

  @override
  Future<List<SocialNews>> getSocialNews(ReadPolicy readPolicy) async {
    List<SocialNews> socialNews = [];

    await rootBundle
        .loadString('assets/stubs/social_news.json')
        .then((fileContents) => json.decode(fileContents))
        .then((jsonData) {
      socialNews = _parser.parse(jsonData);
    });

    return socialNews;
  }
}
