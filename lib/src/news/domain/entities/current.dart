import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/summary.dart';

class CurrentNews extends News {
  final NewsSource source;

  CurrentNews(NewsSummary summary, this.source)
      : assert(summary != null),
        assert(source != null),
        super(summary);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrentNews &&
          runtimeType == other.runtimeType &&
          source == other.source &&
          summary == other.summary;

  @override
  int get hashCode => source.hashCode ^ summary.hashCode;

  @override
  String toString() {
    return 'CurrentNews{summary: $summary, source: $source}';
  }
}

class NewsSource {
  final String name;
  final String image;
  final String url;

  NewsSource(this.name, this.image, this.url)
      : assert(name != null),
        assert(image != null),
        assert(url != null);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsSource &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          image == other.image &&
          url == other.url;

  @override
  int get hashCode => name.hashCode ^ image.hashCode ^ url.hashCode;

  @override
  String toString() {
    return 'NewsSource{name: $name, image: $image, url: $url}';
  }


}
