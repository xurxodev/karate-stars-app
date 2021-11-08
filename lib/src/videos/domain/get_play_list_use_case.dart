import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/videos/domain/boundaries/video_repository.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';

class GetPlayListByVideoIdUseCase {
  final VideoRepository _videoRepository;

  GetPlayListByVideoIdUseCase(this._videoRepository);

  Future<List<Video>> execute(ReadPolicy readPolicy, String videoId) async {
    final videos = await _videoRepository.getAll(readPolicy);

    final video = videos.firstWhere((video) => video.id == videoId);

    if (video.isLive){
      final playList = videos.where((v) => v.isLive && v.id != video.id).toList();
      return [video, ...playList];
    } else {
      final relatedVideos = videos.where((v) {
        return v.competitors
            .any((cId) => video.competitors.contains(cId) && v.id != video.id);
      }).toList();

      relatedVideos.shuffle();

      final nonRelatedVideos = videos.where((v) {
        return v.competitors.any((cId) => !video.competitors.contains(cId));
      }).toList();

      nonRelatedVideos.shuffle();

      final playList = [...relatedVideos, ...nonRelatedVideos];

      return [video, ...playList];
    }
  }
}
