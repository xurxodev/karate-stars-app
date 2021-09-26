import 'package:karate_stars_app/src/competitors/domain/entities/achievement.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';

class CompetitorParser {
  List<Competitor> parse(List<dynamic> json) {
    return json.map((jsonItem) => _parseCompetitor(jsonItem)).toList();
  }

  Competitor _parseCompetitor(Map<String, dynamic> jsonData) {
    final links = (jsonData['links'] as List<dynamic>).map((link) {
      return parseLink(link);
    }).toList();

    final achievements =
        (jsonData['achievements'] as List<dynamic>).map((achievement) {
      return parseAchievement(achievement);
    }).toList();

    return Competitor(
        jsonData['id'],
        jsonData['firstName'],
        jsonData['lastName'],
        jsonData['wkfId'],
        jsonData['biography'],
        jsonData['countryId'],
        jsonData['categoryId'],
        jsonData['mainImage'],
        jsonData['isActive'],
        jsonData['isLegend'],
        links,
        achievements);
  }

  CompetitorLink parseLink(Map<String, dynamic> json) {
    final socialLink = SocialLink.values
        .firstWhere((e) => e.toString().contains(json['type']));

    return CompetitorLink(json['url'], socialLink);
  }

  Achievement parseAchievement(Map<String, dynamic> json) {
    return Achievement(json['eventId'], json['categoryId'], json['position']);
  }
}
