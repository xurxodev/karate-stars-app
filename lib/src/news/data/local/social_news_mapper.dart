import 'package:karate_stars_app/src/news/data/local/social_news_models.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/domain/entities/summary.dart';

class SocialNewsMapper {
  SocialNews mapNewsToDomain(
      SocialNewsDB socialNewsDB, SocialUserDB socialUserDB) {
    final NewsSummary summary = NewsSummary(
        title: socialNewsDB.title,
        link: socialNewsDB.link,
        image: socialNewsDB.image,
        video: socialNewsDB.video,
        pubDate: PubDate(DateTime.parse(socialNewsDB.pubDate)));

    final SocialUser socialUser = SocialUser(socialUserDB.name,
        socialUserDB.userName, socialUserDB.image, socialUserDB.url);

    return News.socialNews(summary, Network.twitter, socialUser) as SocialNews;
  }

  SocialNewsDB mapNewsToDB(SocialNews socialNews, int socialUserId) {
    return SocialNewsDB(
      null,
      socialNews.summary.link ?? '',
      socialNews.summary.title,
      socialNews.summary.image,
      socialNews.summary.video,
      socialNews.summary.pubDate.date.toIso8601String(),
      socialUserId,
      DateTime.now().toIso8601String(),
    );
  }

  SocialUserDB mapSocialUserToDB(SocialUser socialUser) {
    return SocialUserDB(null, socialUser.name, socialUser.userName,
        socialUser.image, socialUser.url, DateTime.now().toIso8601String());
  }
}
