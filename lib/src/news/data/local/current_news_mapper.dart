import 'package:karate_stars_app/src/news/data/local/current_news_models.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';
import 'package:karate_stars_app/src/news/domain/entities/summary.dart';

class CurrentNewsMapper {
  CurrentNews mapNewsToDomain(
      CurrentNewsDB currentNewsDB, CurrentNewsSourceDB currentNewsSourcesDB) {
    final NewsSummary summary = NewsSummary(
        currentNewsDB.title,
        currentNewsDB.link,
        currentNewsDB.image,
        null,
        PubDate(DateTime.parse(currentNewsDB.pubDate)));

    final NewsSource source = NewsSource(currentNewsSourcesDB.name,
        currentNewsSourcesDB.image, currentNewsSourcesDB.url);

    return News.currentNews(summary, source);
  }

  CurrentNewsDB mapNewsToDB(CurrentNews currentNews, int sourceId) {
    return CurrentNewsDB(
        null,
        currentNews.summary.link,
        currentNews.summary.title,
        currentNews.summary.image,
        currentNews.summary.pubDate.date.toIso8601String(),
        DateTime.now().toIso8601String(),
        sourceId);
  }

  CurrentNewsSourceDB mapSourceToDB(NewsSource source) {
    return CurrentNewsSourceDB(null, source.url, source.name, source.image,
        DateTime.now().toIso8601String());
  }

}
