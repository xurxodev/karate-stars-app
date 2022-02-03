import 'package:flutter/foundation.dart';
import 'package:karate_stars_app/src/common/data/local/DataBaseMapper.dart';
import 'package:karate_stars_app/src/competitors/data/local/models/achievement_db.dart';
import 'package:karate_stars_app/src/competitors/data/local/models/competitor_db.dart';
import 'package:karate_stars_app/src/competitors/data/local/models/competitor_link_db.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/achievement.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';

class CompetitorMapper implements DataBaseMapper<Competitor, CompetitorDB> {
  @override
  Competitor mapToDomain(CompetitorDB modelDB) {
    final achievements = modelDB.achievements.map((achievementDB) {
      return Achievement(achievementDB.eventId, achievementDB.categoryId,
          achievementDB.position);
    }).toList();

    final competitorLinks = modelDB.links.map((competitorLinkDB) {
      final SocialLink socialLink = SocialLink.values.firstWhere(
          (e) => e.toString().toLowerCase().contains(competitorLinkDB.type));

      return CompetitorLink(competitorLinkDB.url, socialLink);
    }).toList();

    return Competitor(
        modelDB.id,
        modelDB.firstName,
        modelDB.lastName,
        modelDB.wkfId,
        modelDB.biography,
        modelDB.countryId,
        modelDB.categoryId,
        modelDB.mainImage,
        modelDB.isActive,
        modelDB.isLegend,
        competitorLinks,
        achievements);
  }

  @override
  CompetitorDB mapToDB(Competitor entity) {
    final achievementsDB = entity.achievements.map((achievement) {
      return AchievementDB(
          achievement.eventId, achievement.categoryId, achievement.position);
    }).toList();

    final competitorLinksDB = entity.links.map((competitorLink) {
      return CompetitorLinkDB(
          competitorLink.url, describeEnum(competitorLink.type));
    }).toList();

    return CompetitorDB(
      entity.id,
      entity.firstName,
      entity.lastName,
      entity.wkfId,
      entity.biography,
      entity.countryId,
      entity.categoryId,
      entity.mainImage,
      entity.isActive,
      entity.isLegend,
      competitorLinksDB,
      achievementsDB,
      DateTime.now().toIso8601String(),
    );
  }
}
