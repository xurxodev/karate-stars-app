import 'dart:convert';
import 'dart:io';

import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/domain/entities/summary.dart';
import 'package:karate_stars_app/src/news/domain/social_news_repository.dart';
import 'package:flutter/services.dart' show rootBundle;

class SocialNewsInMemoryRepository implements SocialNewsRepository {
  @override
  Future<List<SocialNews>> execute(ReadPolicy readPolicy) async {
    List<SocialNews> socialNews = [];

    await rootBundle
        .loadString('assets/stubs/social_news.json')
        .then((fileContents) => json.decode(fileContents))
        .then((jsonData) {
      socialNews = _parse(jsonData);
    });

    return socialNews;
  }

  List<SocialNews> _parse(List<dynamic> json) {
    return json.map((jsonItem) => _parseSocialNews(jsonItem)).toList();
  }

  SocialNews _parseSocialNews(Map<String, dynamic> json) {
    final NewsSummary newsSummary = parseNewsSummary(json['summary']);
    final SocialUser socialUser = parseSocialUser(json['user']);
    final Network network = Network.values.firstWhere((e) => e
        .toString()
        .toLowerCase()
        .contains(json['network'].toString().toLowerCase()));

    return SocialNews(newsSummary, network, socialUser);
  }

  NewsSummary parseNewsSummary(Map<String, dynamic> json) {
    final NewsSummary newsSummary = NewsSummary(json['title'], json['link'],
        json['image'], PubDate(DateTime.parse(json['date'])));
    return newsSummary;
  }

  SocialUser parseSocialUser(Map<String, dynamic> json) {
    final SocialUser socialUser =
        SocialUser(json['name'], json['userName'], json['image'], json['url']);
    return socialUser;
  }
}
