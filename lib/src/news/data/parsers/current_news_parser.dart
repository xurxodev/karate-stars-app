import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';
import 'package:karate_stars_app/src/news/domain/entities/summary.dart';

class CurrentNewsParser {
  List<CurrentNews> parse(List<dynamic> json) {
    return json.map((jsonItem) => _parseSocialNews(jsonItem)).toList();
  }

  CurrentNews _parseSocialNews(Map<String, dynamic> json) {
    final NewsSummary newsSummary = parseNewsSummary(json['summary']);
    final NewsSource newsSource = parseNewsSource(json['source']);

    return CurrentNews(newsSummary, newsSource);
  }

  NewsSummary parseNewsSummary(Map<String, dynamic> json) {
    final NewsSummary newsSummary = NewsSummary(
        title: json['title'],
        link: json['link'],
        image: json['image'],
        video: json['video'] ?? '',
        pubDate: PubDate(DateTime.parse(json['date'])));
    return newsSummary;
  }

  NewsSource parseNewsSource(Map<String, dynamic> json) {
    final NewsSource newsSource =
        NewsSource(json['name'], json['image'], json['url']);
    return newsSource;
  }
}
