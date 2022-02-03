import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/competitors/domain/boundaries/competitor_repository.dart';
import 'package:karate_stars_app/src/videos/domain/boundaries/video_repository.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';
import 'package:karate_stars_app/src/videos/domain/videos_filter.dart';

class GetVideosUseCase {
  final VideoRepository _videoRepository;
  final CompetitorRepository _competitorRepository;

  GetVideosUseCase(this._videoRepository, this._competitorRepository);

  Future<List<Video>> execute(
      ReadPolicy readPolicy, VideosFilter videosFilter) async {
    final videos = await _videoRepository.getAll(readPolicy);

    final competitorIdsBySearchTerm = videosFilter.searchTerm != null
        ? (await _competitorRepository.getAll(readPolicy))
            .where((competitor) => competitor
                .fullName()
                .toLowerCase()
                .contains(videosFilter.searchTerm!.toLowerCase()))
            .map((item) => item.id)
            .toList()
        : null;

    final filteredVideos = videos.where((video) {
      return (videosFilter.competitorId == null ||
              video.competitors.contains(videosFilter.competitorId)) &&
          (videosFilter.year == null ||
              video.eventDate.year == videosFilter.year) &&
          (videosFilter.isLive == null ||
              video.isLive == videosFilter.isLive) &&
          (videosFilter.searchTerm == null ||
              video.title
                  .toLowerCase()
                  .contains(videosFilter.searchTerm!.toLowerCase()) ||
              video.subtitle
                  .toLowerCase()
                  .contains(videosFilter.searchTerm!.toLowerCase()) ||
              video.description
                  .toLowerCase()
                  .contains(videosFilter.searchTerm!.toLowerCase()) ||
              video.competitors
                  .any((item) => competitorIdsBySearchTerm!.contains(item)));
    }).toList();

    filteredVideos.sort((a, b) => b.eventDate.compareTo(a.eventDate));

    return filteredVideos;
  }
}
