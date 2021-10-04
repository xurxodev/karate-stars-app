
class Video {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final List<String> competitors;
  final DateTime eventDate;
  final DateTime createdDate;
  final int order;
  final List<VideoLink> links;

  Video(this.id,
      this.title,
      this.subtitle,
      this.description,
      this.competitors,
      this.eventDate,
      this.createdDate,
      this.order,
      this.links);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Video &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          subtitle == other.subtitle &&
          description == other.description &&
          competitors == other.competitors &&
          eventDate == other.eventDate &&
          createdDate == other.createdDate &&
          order == other.order &&
          links == other.links;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      subtitle.hashCode ^
      description.hashCode ^
      competitors.hashCode ^
      eventDate.hashCode ^
      createdDate.hashCode ^
      order.hashCode ^
      links.hashCode;
}

enum VideoLinkType { youtube , facebook , vimeo }

class VideoLink {
  final String id;
  final VideoLinkType type;

  VideoLink(this.id, this.type);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoLink &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type;

  @override
  int get hashCode => id.hashCode ^ type.hashCode;
}
