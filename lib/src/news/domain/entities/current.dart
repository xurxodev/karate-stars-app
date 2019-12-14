import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/summary.dart';

class CurrentNews extends News {
  final NewsSource source;

  CurrentNews(NewsSummary summary, this.source)
      : assert(summary != null),
        assert(source != null),
        super(summary);
}

class NewsSource {
  final String name;
  final String image;
  final String url;

  NewsSource(this.name, this.image, this.url)
      : assert(name != null),
        assert(image != null),
        assert(url != null);
}
