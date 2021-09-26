import 'achievement.dart';

class Competitor {
  final String identifier;
  final String firstName;
  final String lastName;
  final String wkfId;
  final String biography;
  final String countryId;
  final String categoryId;
  final String mainImage;
  final bool isActive;
  final bool isLegend;
  final List<CompetitorLink> links;
  final List<Achievement> achievements;

  Competitor(this.identifier,
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
      this.achievements);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Competitor &&
              runtimeType == other.runtimeType &&
              identifier == other.identifier &&
              firstName == other.firstName &&
              lastName == other.lastName &&
              wkfId == other.wkfId &&
              biography == other.biography &&
              countryId == other.countryId &&
              categoryId == other.categoryId &&
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
      categoryId.hashCode ^
      mainImage.hashCode ^
      isActive.hashCode ^
      isLegend.hashCode ^
      links.hashCode ^
      achievements.hashCode;
}

enum SocialLink { facebook, twitter, instagram, web }

class CompetitorLink {
  final String url;
  final SocialLink type;

  CompetitorLink(this.url, this.type);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompetitorLink &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          type == other.type;

  @override
  int get hashCode => url.hashCode ^ type.hashCode;
}
