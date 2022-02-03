import 'package:flutter/foundation.dart';
import 'package:karate_stars_app/src/common/data/local/DataBaseMapper.dart';
import 'package:karate_stars_app/src/news/data/local/models/social_news_db.dart';
import 'package:karate_stars_app/src/news/data/local/models/social_user_db.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/domain/entities/summary.dart';

class SocialNewsMapper  implements DataBaseMapper<SocialNews,SocialNewsDB>{
  @override
  SocialNews mapToDomain(
      SocialNewsDB socialNewsDB) {

    final SocialUser socialUser = SocialUser(
        socialNewsDB.user.name,
        socialNewsDB.user.userName,
        socialNewsDB.user.image,
        socialNewsDB.user.url);

    final NewsSummary summary = NewsSummary(
        title: socialNewsDB.title,
        link: socialNewsDB.link,
        image: socialNewsDB.image,
        video: socialNewsDB.video,
        pubDate: PubDate(DateTime.parse(socialNewsDB.pubDate)));


    final Network network = Network.values.firstWhere((e) => e
        .toString()
        .toLowerCase()
        .contains(socialNewsDB.network));

    return News.socialNews(summary, network, socialUser) as SocialNews;
  }

  @override
  SocialNewsDB mapToDB(SocialNews socialNews) {
    final user = SocialUserDB(
        socialNews.user.name,
        socialNews.user.userName,
        socialNews.user.image,
        socialNews.user.url);

    return SocialNewsDB(
      describeEnum(socialNews.network),
      socialNews.summary.link ?? '',
      socialNews.summary.title,
      socialNews.summary.image,
      socialNews.summary.video,
      socialNews.summary.pubDate.date.toIso8601String(),
      user,
      DateTime.now().toIso8601String(),
    );
  }
}
