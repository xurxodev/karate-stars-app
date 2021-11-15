import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';

class NewsSummary {
  final String title;
  final String? link;
  final String? image;
  final String? video;
  final PubDate pubDate;

  NewsSummary({required this.title, this.link, this.image, this.video, required this.pubDate});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsSummary &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          link == other.link &&
          image == other.image &&
          video == other.video &&
          pubDate == other.pubDate;

  @override
  int get hashCode =>
      title.hashCode ^
      link.hashCode ^
      image.hashCode ^
      video.hashCode ^
      pubDate.hashCode;

  @override
  String toString() {
    return 'NewsSummary{title: $title, link: $link, image: $image, video: $video, pubDate: $pubDate}';
  }
}
