import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';

class AchievementState {
  final String event;
  final String category;
  final int position;

  AchievementState(this.event, this.category, this.position);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AchievementState &&
          runtimeType == other.runtimeType &&
          event == other.event &&
          category == other.category &&
          position == other.position;

  @override
  int get hashCode => event.hashCode ^ category.hashCode ^ position.hashCode;
}

class CompetitorInfoState {
  final String identifier;
  final String firstName;
  final String lastName;
  final String wkfId;
  final String biography;
  final String countryId;
  final String mainImage;
  final bool isActive;
  final bool isLegend;
  final List<CompetitorLink> links;
  final Map<String, List<AchievementState>> achievements;

  String fullName() {
    return '$firstName $lastName';
  }

  CompetitorInfoState(
      this.identifier,
      this.firstName,
      this.lastName,
      this.wkfId,
      this.biography,
      this.countryId,
      this.mainImage,
      this.isActive,
      this.isLegend,
      this.links,
      this.achievements);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompetitorInfoState &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier &&
          firstName == other.firstName &&
          lastName == other.lastName &&
          wkfId == other.wkfId &&
          biography == other.biography &&
          countryId == other.countryId &&
          mainImage == other.mainImage &&
          isActive == other.isActive &&
          isLegend == other.isLegend &&
          links == other.links &&
          achievements == other.achievements;

  @override
  int get hashCode =>
      identifier.hashCode ^
      firstName.hashCode ^
      lastName.hashCode ^
      wkfId.hashCode ^
      biography.hashCode ^
      countryId.hashCode ^
      mainImage.hashCode ^
      isActive.hashCode ^
      isLegend.hashCode ^
      links.hashCode ^
      achievements.hashCode;
}
