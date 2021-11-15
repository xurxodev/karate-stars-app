import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';
import 'package:karate_stars_app/src/news/domain/entities/summary.dart';

CurrentNews madridHost2018() {
  return News.currentNews(
          NewsSummary(
              title: 'Madrid (Spain) to host 2018 Karate World Championships',
              link:
                  'https://wkf.net/news-center-new/madrid-spain-to-host-2018-karate-world-championships/627/',
              image:
                  'https://wkf.net/imagenes/noticias/madrid-spain-to-host-2018-karate-world-championships-772.jpg',
              video: null,
              pubDate: PubDate(DateTime.now())),
          NewsSource(
              'WKF CurrentNews Center',
              'http://www.karatestarsapp.com/app/logos/wkf.png',
              'http://fetchrss.com/rss/59baa0d28a93f8a1048b4567777611407.xml'))
      as CurrentNews;
}

CurrentNews quinteroNumber1() {
  return News.currentNews(
      NewsSummary(
          title:
              'Damián Quintero finaliza 2017 como número 1 del ranking mundial por tercer año consecutivo',
          link:
              'http://www.damianquintero.com/damian-quintero-finaliza-2017-como-numero-1-del-ranking-mundial-por-tercer-ano-consecutivo/',
          image:
              'http://www.damianquintero.com/wp-content/uploads/CON-RYO-KIYUNA-385x311.jpg',
          video: null,
          pubDate: PubDate(DateTime.now())),
      NewsSource(
          'Damian Quintero',
          'http://www.karatestarsapp.com/app/logos/damian_quintero.png',
          'http://www.damianquintero.com/feed/')) as CurrentNews;
}

CurrentNews stevenDaCostaVideo() {
  return News.currentNews(
      NewsSummary(
          title:
              'Video / Steven Da Costa : « To say no one stops me anymore... »',
          link:
              'http://karate-k.com/en/sport/news/419-video-steven-da-costa-to-say-no-one-stops-me-anymore.html',
          image:
              'http://karate-k.com/images/France/Da_Costa_Steven_-_DubaiF-080_retouchée.jpg',
          video: null,
          pubDate: PubDate(DateTime.now())),
      NewsSource(
          'karate-k',
          'http://www.karatestarsapp.com/app/logos/karate_k.png',
          'http://karate-k.com/en/?format=feed&type=rss')) as CurrentNews;
}

List<CurrentNews> allCurrentNews() {
  return [madridHost2018(), quinteroNumber1(), stevenDaCostaVideo()];
}
