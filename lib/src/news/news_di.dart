import 'package:get_it/get_it.dart';
import 'package:karate_stars_app/src/news/data/current_news_inmemory_repository.dart';
import 'package:karate_stars_app/src/news/data/social_news_inmemory_repository.dart';
import 'package:karate_stars_app/src/news/domain/get_news_use_case.dart';
import 'package:karate_stars_app/src/news/presentation/blocs/news_bloc.dart';
import 'package:karate_stars_app/src/news/domain/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/social_news_repository.dart';

final getIt = GetIt.instance;

void init(){
  getIt.registerFactory(() => NewsBloc(getIt()));

  getIt.registerLazySingleton(() => GetNewsUseCase(getIt(), getIt()));

  getIt.registerLazySingleton<CurrentNewsRepository>(
      () => CurrentNewsInMemoryRepository());

  getIt.registerLazySingleton<SocialNewsRepository>(
          () => SocialNewsInMemoryRepository());
}
