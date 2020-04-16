import 'package:karate_stars_app/src/news/data/local/models/current_news_db.dart';
import 'package:karate_stars_app/src/news/data/local/models/current_news_source_db.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';
import 'package:karate_stars_app/src/news/domain/entities/summary.dart';

class CurrentNewsMapper {
  CurrentNews mapNewsToDomain(
      CurrentNewsDB currentNewsDB) {
    final NewsSummary summary = NewsSummary(
        currentNewsDB.title,
        currentNewsDB.link,
        currentNewsDB.image,
        null,
        PubDate(DateTime.parse(currentNewsDB.pubDate)));

    final NewsSource source = NewsSource(currentNewsDB.source.name,
        currentNewsDB.source.image, currentNewsDB.source.url);

    return News.currentNews(summary, source);
  }

  CurrentNewsDB mapNewsToDB(CurrentNews currentNews) {
    final source = CurrentNewsSourceDB(
        currentNews.source.url,
        currentNews.source.name,
        currentNews.source.image,
        DateTime.now().toIso8601String());

    return CurrentNewsDB(
      currentNews.summary.title,
      currentNews.summary.link,
      currentNews.summary.image,
      null,
      currentNews.summary.pubDate.date.toIso8601String(),
      source,
      DateTime.now().toIso8601String(),
    );
  }
}
