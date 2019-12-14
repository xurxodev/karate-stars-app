import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/domain/entities/summary.dart';

abstract class News {
  final NewsSummary summary;

  News(this.summary) : assert(summary != null);

  factory News.currentNews(NewsSummary summary, NewsSource source) {
    return CurrentNews(summary, source);
  }

  factory News.socialNews(
      NewsSummary summary, Network network, SocialUser user) {
    return SocialNews(summary, network, user);
  }
}
