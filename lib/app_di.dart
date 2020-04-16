import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:karate_stars_app/src/common/auth/api_credentials_loader.dart';
import 'package:karate_stars_app/src/common/data/remote/token_storage.dart';
import 'package:karate_stars_app/src/news/news_di.dart' as news_di;

final getIt = GetIt.instance;

int largeCacheTimeMillis = const Duration(days: 7).inMilliseconds;
int mediumCacheTimeMillis = const Duration(hours: 4).inMilliseconds;
int smallCacheTimeMillis = const Duration(hours: 1).inMilliseconds;

const String apiBaseAddress = 'https://karate-stars-api.herokuapp.com/v1';
//const String baseAddress = 'http://10.0.2.2:8000/v1';

Future<void> init() async {
  _initAppDependencies();

  Hive.initFlutter();

  final Credentials apiCredentials =
      await ApiCredentialsLoader('assets/credentials.json').load();

  await news_di.initAll(apiCredentials);
}

void initWithoutDataDependencies() {
  news_di.initBlocAndUseCases();
}

void reset() {
  getIt.reset();
}

void _initAppDependencies() {
  getIt.registerLazySingleton<ApiTokenStorage>(() => ApiTokenSecureStorage());
}
