import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/summary.dart';

class LiveVideoNews extends News {
  final String firstVideoId;
  LiveVideoNews(NewsSummary summary, this.firstVideoId) : super(summary);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LiveVideoNews &&
          runtimeType == other.runtimeType &&
          firstVideoId == other.firstVideoId;

  @override
  int get hashCode => firstVideoId.hashCode;
}