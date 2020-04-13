import 'dart:async';

import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/news/domain/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/news_filter.dart';
import 'package:karate_stars_app/src/news/domain/social_news_repository.dart';

class GetNewsUseCase {
  final CurrentNewsRepository _currentNewsRepository;
  final SocialNewsRepository _socialNewsRepository;
  final _newsController = StreamController<List<News>>.broadcast();

  GetNewsUseCase(this._currentNewsRepository, this._socialNewsRepository);

  final compareByDate =
      (News a, News b) => b.summary.pubDate.date.compareTo(a.summary.pubDate.date);

  Stream<List<News>> execute(ReadPolicy readPolicy, NewsFilter newsFilter) {
    List<News> news = [];

    if (newsFilter == NewsFilter.all || newsFilter == NewsFilter.current) {
      _currentNewsRepository.getCurrentNews(readPolicy).listen((currentNews) {
        final nonCurrentNews =
            news.where((newsItem) => !(newsItem is CurrentNews)).toList();
        news = [...nonCurrentNews, ...currentNews];
        news.sort(compareByDate);

        _newsController.add(news);
      });
    }

    if (newsFilter == NewsFilter.all || newsFilter == NewsFilter.social) {
      _socialNewsRepository.getSocialNews(readPolicy).listen((socialNews) {
        final nonSocialNews =
        news.where((newsItem) => !(newsItem is CurrentNews)).toList();
        news = [...nonSocialNews, ...socialNews];
        news.sort(compareByDate);

        _newsController.add(news);
      });
    }

    return _newsController.stream;
  }
}
