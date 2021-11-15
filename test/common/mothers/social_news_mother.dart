import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/domain/entities/summary.dart';

SocialNews newVideoInKarateStars() {
  return News.socialNews(
      NewsSummary(
          title:'EKF Senior Championships cancelled over coronavirus outbreak https://t.co/P2i7Ihogpo?amp=1',
          link: 'https://twitter.com/worldkarate_wkf/status/1238499006063542278',
          image:'',
          video:null,
          pubDate: PubDate(DateTime.now())),
      Network.twitter,
      SocialUser(
          'World Karate Federation',
          'worldkarate_wkf',
          '',
          //'https://pbs.twimg.com/profile_images/1229708688597880833/PiQoEC9T_reasonably_small.jpg',
          'https://twitter.com/worldkarate_wkf')) as SocialNews;
}

SocialNews countDownMadrid2018() {
  return News.socialNews(
      NewsSummary(
          title:'The countdown to the big #KARATE event of the year has already started!',
         link: 'https://twitter.com/wkf_tweet/status/961155264211836928',
          image:'', //'https://pbs.twimg.com/media/DVa1YUhX4AAW4hN.jpg',
          video:null,
          pubDate: PubDate(DateTime.now())),
      Network.twitter,
      SocialUser(
          'World Karate Federation',
          'worldkarate_wkf',
          '',
          //'https://pbs.twimg.com/profile_images/1229708688597880833/PiQoEC9T_reasonably_small.jpg',
          'https://twitter.com/worldkarate_wkf')) as SocialNews;
}

List<SocialNews> allSocialNews() {
  return [countDownMadrid2018(), newVideoInKarateStars()];
}
