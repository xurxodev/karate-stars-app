import 'package:karate_stars_app/dependencies_provider.dart';
import 'package:karate_stars_app/src/news/data/repositories/current_news_inmemory_repository.dart';
import 'package:karate_stars_app/src/news/data/repositories/social_news_network_repository.dart';
import 'package:karate_stars_app/src/news/domain/get_news_use_case.dart';
import 'package:karate_stars_app/src/news/presentation/blocs/news_bloc.dart';
import 'package:karate_stars_app/src/news/domain/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/social_news_repository.dart';

void init() {
  getIt.registerFactory(() => NewsBloc(getIt()));

  getIt.registerLazySingleton(() => GetNewsUseCase(getIt(), getIt()));

  getIt.registerLazySingleton<CurrentNewsRepository>(
      () => CurrentNewsInMemoryRepository());

  getIt.registerLazySingleton<SocialNewsRepository>(
      () => SocialNewsNetworkRepository());
  //() => SocialNewsInMemoryRepository());
}
