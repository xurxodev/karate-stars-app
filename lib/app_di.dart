import 'package:get_it/get_it.dart';
import 'package:karate_stars_app/src/common/analytics/firebase_analytics_service.dart';
import 'package:karate_stars_app/src/common/auth/api_credentials_loader.dart';
import 'package:karate_stars_app/src/common/data/database.dart';
import 'package:karate_stars_app/src/common/data/remote/token_storage.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/news/news_di.dart' as news_di;
import 'package:karate_stars_app/src/competitors/competitors_di.dart' as competitors_di;

final getIt = GetIt.instance;

int largeCacheTimeMillis = const Duration(days: 7).inMilliseconds;
int mediumCacheTimeMillis = const Duration(hours: 4).inMilliseconds;
int smallCacheTimeMillis = const Duration(hours: 1).inMilliseconds;

const String apiBaseAddress = 'https://karate-stars-web.herokuapp.com/api/v1';
//const String baseAddress = 'http://10.0.2.2:8000/v1';

Future<void> init() async {
  initNoDataAppDependencies();

  final AppDatabase appDatabase =
      await $FloorAppDatabase.databaseBuilder('karate_stars.db').build();

  final Credentials apiCredentials =
      await ApiCredentialsLoader('assets/credentials.json').load();

  getIt.registerLazySingleton<ApiTokenStorage>(() => ApiTokenSecureStorage());

  news_di.initAll(appDatabase, apiCredentials);
  competitors_di.initAll(appDatabase, apiCredentials);
}

void initWithoutDataDependencies() {
  initNoDataAppDependencies();

  news_di.initBlocAndUseCases();
  competitors_di.initBlocAndUseCases();
}

void initNoDataAppDependencies() {
  getIt.registerLazySingleton<AnalyticsService>(
          () => FirebaseAnalyticsService());
}

void reset() {
  getIt.reset();
}

