import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';

abstract class VideoRepository {
  Future<List<Video>> getAll(ReadPolicy readPolicy);
}
