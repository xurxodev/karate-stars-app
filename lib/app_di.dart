import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:karate_stars_app/src/categories/category_di.dart'
as category_di;
import 'package:karate_stars_app/src/category_types/category_types_di.dart'
as category_types_di;
import 'package:karate_stars_app/src/common/analytics/firebase_analytics_service.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/database.dart';
import 'package:karate_stars_app/src/common/data/remote/token_storage.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/competitors/competitors_di.dart'
    as competitors_di;
import 'package:karate_stars_app/src/countries/countries_di.dart'
as countries_di;
import 'package:karate_stars_app/src/news/news_di.dart' as news_di;

final getIt = GetIt.instance;

int largeCacheTimeMillis = const Duration(days: 7).inMilliseconds;
int mediumCacheTimeMillis = const Duration(hours: 4).inMilliseconds;
int smallCacheTimeMillis = const Duration(hours: 1).inMilliseconds;

Future<void> init() async {
  getIt.allowReassignment = true;
  initNoDataAppDependencies();

  final AppDatabase appDatabase =
      await $FloorAppDatabase.databaseBuilder('karate_stars.db').build();

  final apiBaseAddress = dotenv.env['API_URL'] ?? '';
  final username = dotenv.env['API_USERNAME'] ?? '';
  final password = dotenv.env['API_PASSWORD'] ?? '';

  if (apiBaseAddress.isEmpty || username.isEmpty || password.isEmpty)
    throw Exception(
        'URL or environment variables for api credentials are not configured');

  final Credentials apiCredentials = Credentials(username, password);

  getIt.registerLazySingleton<ApiTokenStorage>(() => ApiTokenSecureStorage());

  news_di.initAll(appDatabase, apiBaseAddress, apiCredentials);
  competitors_di.initAll(appDatabase, apiBaseAddress, apiCredentials);
  countries_di.initAll(appDatabase, apiBaseAddress, apiCredentials);
  category_di.initAll(appDatabase, apiBaseAddress, apiCredentials);
  category_types_di.initAll(appDatabase, apiBaseAddress, apiCredentials);
}

void initWithoutDataDependencies() {
  getIt.allowReassignment = true;
  initNoDataAppDependencies();

  news_di.initBlocAndUseCases();
  competitors_di.initBlocAndUseCases();
  countries_di.initBlocAndUseCases();
  category_di.initBlocAndUseCases();
  category_types_di.initBlocAndUseCases();
}

void initNoDataAppDependencies() {
  getIt.registerLazySingleton<AnalyticsService>(
      () => FirebaseAnalyticsService());
}

Future<void> reset() {
  return getIt.reset();
}
