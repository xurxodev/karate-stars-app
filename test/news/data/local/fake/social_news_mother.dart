import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/domain/entities/summary.dart';

class SocialNewsMother {
  static SocialNews newVideoInKarateStars() {
    return News.socialNews(
        NewsSummary(
            'new Video',
            'https://twitter.com/karatestarsapp/status/961155264211836928',
            '',
            null,
            PubDate(DateTime.now())),
        Network.twitter,
        SocialUser(
            'Karate Stars',
            'karatestarsapp',
            'ttps://pbs.twimg.com/profile_images/902953212696768523/wMWePMB9_400x400.jpg',
            'https://twitter.com/karatestarsapp'));
  }

  static SocialNews countDownMadrid2018() {
    return News.socialNews(
        NewsSummary(
            'The countdown to the big #KARATE event of the year has already started!',
            'https://twitter.com/wkf_tweet/status/961155264211836928',
            'https://pbs.twimg.com/media/DVa1YUhX4AAW4hN.jpg',
            null,
            PubDate(DateTime.now())),
        Network.twitter,
        SocialUser(
            'WKF',
            'wkf_tweet',
            'https://pbs.twimg.com/profile_images/958718495415468032/tMWunfE3_bigger.jpg',
            'https://twitter.com/wkf_tweet'));
  }
}
