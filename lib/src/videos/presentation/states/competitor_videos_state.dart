import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';

typedef CompetitorVideosState = DefaultState<CompetitorVideos>;

class CompetitorVideos {
  final String id;
  final String name;
  final String image;
  final List<Video> videos;

  CompetitorVideos(this.id, this.name, this.image, this.videos);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompetitorVideos &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          image == other.image &&
          videos == other.videos;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ image.hashCode ^ videos.hashCode;
}
