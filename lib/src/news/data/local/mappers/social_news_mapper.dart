import 'package:karate_stars_app/src/news/data/local/models/social_news_db.dart';
import 'package:karate_stars_app/src/news/data/local/models/social_user_db.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/domain/entities/summary.dart';

class SocialNewsMapper {
  SocialNews mapNewsToDomain(SocialNewsDB socialNewsDB) {
    final NewsSummary summary = NewsSummary(
        socialNewsDB.title,
        socialNewsDB.link,
        socialNewsDB.image,
        socialNewsDB.video,
        PubDate(DateTime.parse(socialNewsDB.pubDate)));

    final SocialUser socialUser = SocialUser(
        socialNewsDB.user.name,
        socialNewsDB.user.userName,
        socialNewsDB.user.image,
        socialNewsDB.user.url);

    return News.socialNews(summary, Network.twitter, socialUser);
  }

  SocialNewsDB mapNewsToDB(SocialNews socialNews) {
    final user = SocialUserDB(
        socialNews.user.name,
        socialNews.user.userName,
        socialNews.user.image,
        socialNews.user.url,
        DateTime.now().toIso8601String());

    return SocialNewsDB(
      socialNews.summary.link,
      socialNews.summary.title,
      socialNews.summary.image,
      socialNews.summary.video,
      socialNews.summary.pubDate.date.toIso8601String(),
      user,
      DateTime.now().toIso8601String(),
    );
  }
}
