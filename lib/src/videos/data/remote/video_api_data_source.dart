import 'dart:convert';

import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/remote/api_data_source.dart';
import 'package:karate_stars_app/src/common/data/remote/token_storage.dart';
import 'package:karate_stars_app/src/videos/data/remote/video_parser.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';

class VideoApiDataSource extends ApiDataSource
    implements ReadableDataSource<Video> {
  final parser = VideoParser();

  VideoApiDataSource(String baseAddress, Credentials apiCredentials,
      ApiTokenStorage apiTokenStorage)
      : super(baseAddress, apiCredentials, apiTokenStorage);

  @override
  Future<List<Video>> getAll() async {
    return await _fetchVideos();
  }

  Future<List<Video>> _fetchVideos() async {
    final response = await super.get('/videos');

    try {
      return parser.parse(json.decode(response.body));
    } on Exception {
      print(response.body);
      rethrow;
    }
  }
}
