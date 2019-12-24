import 'dart:convert';

import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/news/domain/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';
import 'package:karate_stars_app/src/news/domain/entities/summary.dart';
import 'package:flutter/services.dart' show rootBundle;

class CurrentNewsInMemoryRepository implements CurrentNewsRepository {
  @override
  Future<List<CurrentNews>> execute(ReadPolicy readPolicy) async {
    List<CurrentNews> currentNews = [];

    await rootBundle.loadString('assets/stubs/current_news.json')
        .then((fileContents) => json.decode(fileContents))
        .then((jsonData) {
      currentNews = _parse(jsonData);
    });

    return currentNews;
  }

  List<CurrentNews> _parse(List<dynamic> json) {
    return json.map((jsonItem) => _parseCurrentNews(jsonItem)).toList();
  }

  CurrentNews _parseCurrentNews(Map<String, dynamic> json) {
    final NewsSummary newsSummary = parseNewsSummary(json['summary']);
    final NewsSource newsSource = parseNewsSource(json['source']);

    return CurrentNews(newsSummary, newsSource);
  }

  NewsSummary parseNewsSummary(Map<String, dynamic> json) {
    final NewsSummary newsSummary = NewsSummary(json['title'], json['link'],
        json['image'],'', PubDate(DateTime.parse(json['date'])));
    return newsSummary;
  }

  NewsSource parseNewsSource(Map<String, dynamic> json) {
    final NewsSource newsSource =
        NewsSource(json['name'], json['image'], json['url']);
    return newsSource;
  }
}
