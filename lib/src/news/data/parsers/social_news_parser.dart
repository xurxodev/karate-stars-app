import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/domain/entities/summary.dart';

class SocialNewsParser {
  List<SocialNews> parse(List<dynamic> json) {
    return json.map((jsonItem) => _parseSocialNews(jsonItem)).toList();
  }

  SocialNews _parseSocialNews(Map<String, dynamic> json) {
    final NewsSummary newsSummary = parseNewsSummary(json['summary']);
    final SocialUser socialUser = parseSocialUser(json['user']);
    final Network network = Network.values.firstWhere((e) => e
        .toString()
        .toLowerCase()
        .contains(json['network'].toString().toLowerCase()));

    return SocialNews(newsSummary, network, socialUser);
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

  SocialUser parseSocialUser(Map<String, dynamic> json) {
    final SocialUser socialUser =
        SocialUser(json['name'], json['userName'], json['image'], json['url']);
    return socialUser;
  }
}
