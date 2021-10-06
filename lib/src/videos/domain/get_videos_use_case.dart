import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/videos/domain/boundaries/video_repository.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';
import 'package:karate_stars_app/src/videos/domain/videos_filter.dart';

class GetVideosUseCase {
  final VideoRepository _videoRepository;

  GetVideosUseCase(this._videoRepository);

  Future<List<Video>> execute(
      ReadPolicy readPolicy, VideosFilter videosFilter) async {
    final videos = await _videoRepository.getAll(readPolicy);

    final filteredVideos = videos.where((video) {
      return (videosFilter.competitorId == null ||
              video.competitors.contains(videosFilter.competitorId)) &&
          (videosFilter.year == null ||
              video.eventDate.year == videosFilter.year);
    }).toList();

    filteredVideos.sort((a, b) => b.eventDate.compareTo(a.eventDate));

    return filteredVideos;
  }
}
