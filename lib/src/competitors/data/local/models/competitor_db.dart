import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/competitors/data/local/models/achievement_db.dart';
import 'package:karate_stars_app/src/competitors/data/local/models/competitor_link_db.dart';

part 'competitor_db.g.dart';

@HiveType(typeId: 6)
class CompetitorDB implements ModelDB {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String wkfId;

  @HiveField(4)
  final String biography;

  @HiveField(5)
  final String countryId;

  @HiveField(6)
  final String categoryId;

  @HiveField(7)
  final String mainImage;

  @HiveField(8)
  final bool isActive;

  @HiveField(9)
  final bool isLegend;

  @HiveField(10)
  final List<CompetitorLinkDB> links;

  @HiveField(11)
  final List<AchievementDB> achievements;

  @override
  @HiveField(12)
  final String lastUpdate;

  CompetitorDB(
      this.id,
      this.firstName,
      this.lastName,
      this.wkfId,
      this.biography,
      this.countryId,
      this.categoryId,
      this.mainImage,
      this.isActive,
      this.isLegend,
      this.links,
      this.achievements,
      this.lastUpdate);
}
