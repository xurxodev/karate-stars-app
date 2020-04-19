import 'package:karate_stars_app/src/competitors/domain/entities/achievement.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';

class CompetitorParser {
  List<Competitor> parse(List<dynamic> json) {
    return json.map((jsonItem) => _parseCompetitor(jsonItem)).toList();
  }

  Competitor _parseCompetitor(Map<String, dynamic> json) {
    final links = parseLinks(json['links']);

    final achievements = (json['achievements'] as List<dynamic>).map((achievement) {
      return parseAchievement(achievement);
    }).toList();

    return Competitor(
        json['identifier'],
        json['name'],
        json['biography'],
        json['countryId'],
        json['categoryId'],
        json['mainImage'],
        json['isStar'],
        json['isLegend'],
        links,
        achievements);
  }

  CompetitorLinks parseLinks(Map<String, dynamic> json) {
    return CompetitorLinks(
        json['web'], json['twitter'], json['facebook'], json['instagram']);
  }

  Achievement parseAchievement(Map<String, dynamic> json) {
    final achievementDetails =
    (json['details'] as List<dynamic>).map((detail) {
      return parseAchievementDetail(detail);
    }).toList();

    return Achievement(json['name'], achievementDetails);
  }

  AchievementDetail parseAchievementDetail(Map<String, dynamic> json) {
    return AchievementDetail(json['category'], json['name'], json['position']);
  }
}
