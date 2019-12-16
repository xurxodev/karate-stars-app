import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';

class NewsSummary {
  final String title;
  final String link;
  final String image;
  final String video;
  final PubDate pubDate;

  NewsSummary(this.title, this.link, this.image, this.video, this.pubDate)
      : assert(title != null),
        assert(link != null),
        assert(pubDate != null);
}
