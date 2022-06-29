import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';

part 'ranking_entry_db.g.dart';

@HiveType(typeId: 15)
class RankingEntryDB extends HiveObject implements CacheablePartialModelDB {
  @override
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String rankingId;

  @HiveField(2)
  final int rank;

  @HiveField(3)
  final String country;

  @HiveField(4)
  final String countryCode;

  @HiveField(5)
  final String name;

  @HiveField(6)
  final String firstName;

  @HiveField(7)
  final String lastName;

  @HiveField(8)
  final String wkfId;

  @HiveField(9)
  final String photo;

  @HiveField(10)
  final double totalPoints;

  @HiveField(11)
  final String continentalCode;

  @HiveField(12)
  final String categoryId;

  @HiveField(13)
  final String categoryWkfId;

  @override
  @HiveField(14)
  final String lastUpdate;

  RankingEntryDB(
      this.id,
      this.rankingId,
      this.rank,
      this.country,
      this.countryCode,
      this.name,
      this.firstName,
      this.lastName,
      this.wkfId,
      this.photo,
      this.totalPoints,
      this.continentalCode,
      this.categoryId,
      this.categoryWkfId,
      this.lastUpdate);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rankingId': rankingId,
      'rank': rank,
      'country': country,
      'countryCode': countryCode,
      'name': name,
      'firstName': firstName,
      'lastName': lastName,
      'wkfId': wkfId,
      'photo': photo,
      'totalPoints': totalPoints,
      'continentalCode': continentalCode,
      'categoryId': categoryId,
      'categoryWkfId': categoryWkfId,
      'lastUpdate': lastUpdate,
    };
  }
}
