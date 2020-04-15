import 'achievement.dart';

class Competitor {
  final String identifier;
  final String name;
  final String biography;
  final String countryId;
  final String categoryId;
  final String mainImage;
  final bool isStar;
  final bool isLegend;
  final CompetitorLinks links;
  final List<Achievement> achievements;

  Competitor(this.identifier, this.name, this.biography, this.countryId,
      this.categoryId, this.mainImage, this.isStar, this.isLegend, this.links,
      this.achievements);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Competitor &&
              runtimeType == other.runtimeType &&
              identifier == other.identifier &&
              name == other.name &&
              biography == other.biography &&
              countryId == other.countryId &&
              categoryId == other.categoryId &&
              mainImage == other.mainImage &&
              isStar == other.isStar &&
              isLegend == other.isLegend &&
              links == other.links &&
              achievements == other.achievements;

  @override
  int get hashCode =>
      identifier.hashCode ^
      name.hashCode ^
      biography.hashCode ^
      countryId.hashCode ^
      categoryId.hashCode ^
      mainImage.hashCode ^
      isStar.hashCode ^
      isLegend.hashCode ^
      links.hashCode ^
      achievements.hashCode;
}

class CompetitorLinks {
  final String web;
  final String twitter;
  final String facebook;
  final String instagram;

  CompetitorLinks(this.web, this.twitter, this.facebook, this.instagram);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CompetitorLinks &&
              runtimeType == other.runtimeType &&
              web == other.web &&
              twitter == other.twitter &&
              facebook == other.facebook &&
              instagram == other.instagram;

  @override
  int get hashCode =>
      web.hashCode ^
      twitter.hashCode ^
      facebook.hashCode ^
      instagram.hashCode;
}

