import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/social_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/news_filter.dart';

class GetNewsUseCase {
  final CurrentNewsRepository _currentNewsRepository;
  final SocialNewsRepository _socialNewsRepository;

  GetNewsUseCase(this._currentNewsRepository, this._socialNewsRepository);

  Future<List<News>> execute(
      ReadPolicy readPolicy, NewsFilter newsFilter) async {
    final currentNews = await getCurrentNews(readPolicy, newsFilter);

    final socialNews = await getSocialNews(readPolicy, newsFilter);

    final List<News> news = [...currentNews, ...socialNews];

    news.sort(
        (a, b) => b.summary.pubDate.date.compareTo(a.summary.pubDate.date));

    return news;
  }

  Future<List<News>> getSocialNews(
      ReadPolicy readPolicy, NewsFilter newsFilter) async {
    if (newsFilter.type == NewsType.all || newsFilter.type == NewsType.social) {
      final socialNews = await _socialNewsRepository.getAll(readPolicy);

      final filteredSocialNews = newsFilter.searchTerm != null
          ? socialNews
              .where((item) =>
                  item.user.name
                      .toLowerCase()
                      .contains(newsFilter.searchTerm!) ||
                  item.summary.title
                      .toLowerCase()
                      .contains(newsFilter.searchTerm!))
              .toList()
          : socialNews;

      return filteredSocialNews;
    } else {
      return [];
    }
  }

  Future<List<News>> getCurrentNews(
      ReadPolicy readPolicy, NewsFilter newsFilter) async {
    if (newsFilter.type == NewsType.all ||
        newsFilter.type == NewsType.current) {
      final currentNews = await _currentNewsRepository.getAll(readPolicy);

      final filteredCurrentNews = newsFilter.searchTerm != null
          ? currentNews
              .where((item) =>
                  item.source.name
                      .toLowerCase()
                      .contains(newsFilter.searchTerm!.toLowerCase()) ||
                  item.summary.title
                      .toLowerCase()
                      .contains(newsFilter.searchTerm!.toLowerCase()))
              .toList()
          : currentNews;

      return filteredCurrentNews;
    } else {
      return [];
    }
  }
}
