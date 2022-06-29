import 'package:karate_stars_app/src/common/domain/types.dart';

class RankingEntry implements Identifiable {
  @override
  final String id;

  final String rankingId;
  final int rank;
  final String country;
  final String countryCode;
  final String name;
  final String firstName;
  final String lastName;
  final String wkfId;
  final String photo;
  final double totalPoints;
  final String continentalCode;
  final String categoryId;
  final String categoryWkfId;

  RankingEntry(
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
      this.categoryWkfId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RankingEntry &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          rankingId == other.rankingId &&
          rank == other.rank &&
          country == other.country &&
          countryCode == other.countryCode &&
          name == other.name &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          wkfId == other.wkfId &&
          photo == other.photo &&
          totalPoints == other.totalPoints &&
          continentalCode == other.continentalCode &&
          categoryId == other.categoryId &&
          categoryWkfId == other.categoryWkfId;

  @override
  int get hashCode =>
      id.hashCode ^
      rankingId.hashCode ^
      rank.hashCode ^
      country.hashCode ^
      countryCode.hashCode ^
      name.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      wkfId.hashCode ^
      photo.hashCode ^
      totalPoints.hashCode ^
      continentalCode.hashCode ^
      categoryId.hashCode ^
      categoryWkfId.hashCode;
}
