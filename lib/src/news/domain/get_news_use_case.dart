import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/social_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/news_filter.dart';

class GetNewsUseCase {
  final CurrentNewsRepository _currentNewsRepository;
  final SocialNewsRepository _socialNewsRepository;

  GetNewsUseCase(this._currentNewsRepository, this._socialNewsRepository);

  Future<List<News>> execute(
      ReadPolicy readPolicy, NewsFilter newsFilter) async {
    final List<News> news = [];

    if (newsFilter == NewsFilter.all || newsFilter == NewsFilter.current) {
      final currentNews = await _currentNewsRepository.getCurrentNews(readPolicy);

      news.addAll(currentNews);
    }

    if (newsFilter == NewsFilter.all || newsFilter == NewsFilter.social) {
      final socialNews = await _socialNewsRepository.getSocialNews(readPolicy);

      news.addAll(socialNews);
    }

    news.sort(
        (a, b) => b.summary.pubDate.date.compareTo(a.summary.pubDate.date));

    return news;
  }
}
