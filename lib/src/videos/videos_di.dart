import 'package:hive/hive.dart';
import 'package:karate_stars_app/src/global_di.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/local/database.dart';
import 'package:karate_stars_app/src/videos/data/local/models/video_db.dart';
import 'package:karate_stars_app/src/videos/data/local/video_hive_data_source.dart';
import 'package:karate_stars_app/src/videos/data/remote/video_api_data_source.dart';
import 'package:karate_stars_app/src/videos/data/video_cached_repository.dart';
import 'package:karate_stars_app/src/videos/domain/boundaries/video_repository.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';
import 'package:karate_stars_app/src/videos/domain/get_play_list_use_case.dart';
import 'package:karate_stars_app/src/videos/domain/get_videos_use_case.dart';
import 'package:karate_stars_app/src/videos/presentation/blocs/competitor_videos_bloc.dart';
import 'package:karate_stars_app/src/videos/presentation/blocs/video_player_bloc.dart';
import 'package:karate_stars_app/src/videos/presentation/blocs/videos_bloc.dart';

void initAll(Database database, String apiUrl, Credentials apiCredentials) {
  _initDataDI(database, apiUrl, apiCredentials);

  initBlocAndUseCases();
}

void initBlocAndUseCases() {
  getIt.registerFactory(() => VideosBloc(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => VideoPlayerBloc(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => CompetitorVideosBloc(getIt(), getIt(), getIt()));

  getIt.registerLazySingleton(() => GetVideosUseCase(getIt(), getIt()));
  getIt.registerLazySingleton(() => GetPlayListByVideoIdUseCase(getIt()));
}

void _initDataDI(Database database, String apiUrl, Credentials apiCredentials) {
  getIt.registerLazySingleton<ReadableDataSource<Video>>(
      () => VideoApiDataSource(apiUrl, apiCredentials, getIt()));

  getIt.registerLazySingleton<Box<VideoDB>>(() => database.videosBox);

  getIt.registerLazySingleton<CacheableDataSource<Video>>(
      () => VideoHiveDataSource(getIt(), largeCacheTimeMillis));

  getIt.registerLazySingleton<VideoRepository>(
      () => VideoCachedRepository(getIt(), getIt()));
}
