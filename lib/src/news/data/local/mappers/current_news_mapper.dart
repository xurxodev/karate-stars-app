import 'package:karate_stars_app/src/common/data/local/DataBaseMapper.dart';
import 'package:karate_stars_app/src/news/data/local/models/current_news_db.dart';
import 'package:karate_stars_app/src/news/data/local/models/current_news_source_db.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';
import 'package:karate_stars_app/src/news/domain/entities/summary.dart';

class CurrentNewsMapper implements DataBaseMapper<CurrentNews,CurrentNewsDB>{
  @override
  CurrentNews mapToDomain(CurrentNewsDB currentNewsDB) {
    final NewsSource source = NewsSource(currentNewsDB.source.name,
        currentNewsDB.source.image, currentNewsDB.source.url);

    final NewsSummary summary = NewsSummary(
        title: currentNewsDB.title,
        link: currentNewsDB.link,
        image: currentNewsDB.image,
        pubDate: PubDate(DateTime.parse(currentNewsDB.pubDate)));

    return News.currentNews(summary, source) as CurrentNews;
  }

  @override
  CurrentNewsDB mapToDB(CurrentNews currentNews) {
    final source = CurrentNewsSourceDB(
        currentNews.source.url,
        currentNews.source.name,
        currentNews.source.image,
        DateTime.now().toIso8601String());

    return CurrentNewsDB(
      currentNews.summary.title,
      currentNews.summary.link ?? '',
      currentNews.summary.image,
      currentNews.summary.video,
      currentNews.summary.pubDate.date.toIso8601String(),
      source,
      DateTime.now().toIso8601String(),
    );
  }
}
