import 'dart:convert';

import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/news/data/parsers/current_news_parser.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:flutter/services.dart' show rootBundle;

class CurrentNewsInMemoryRepository implements CurrentNewsRepository {
  final CurrentNewsParser _parser = CurrentNewsParser();

  @override
  Future<List<CurrentNews>> getCurrentNews(ReadPolicy readPolicy) async {
    List<CurrentNews> currentNews = [];

    await rootBundle.loadString('assets/stubs/current_news.json')
        .then((fileContents) => json.decode(fileContents))
        .then((jsonData) {
      currentNews = _parser.parse(jsonData);
    });

    return currentNews;
  }
}
