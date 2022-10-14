import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:karate_stars_app/src/categories/category_di.dart'
    as category_di;
import 'package:karate_stars_app/src/category_types/category_types_di.dart'
    as category_types_di;
import 'package:karate_stars_app/src/common/analytics/firebase_analytics_service.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/local/database.dart';
import 'package:karate_stars_app/src/common/data/remote/token_storage.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/competitors/competitors_di.dart'
    as competitors_di;
import 'package:karate_stars_app/src/countries/countries_di.dart'
    as countries_di;
import 'package:karate_stars_app/src/event_types/event_types_di.dart'
    as event_types_di;
import 'package:karate_stars_app/src/events/event_di.dart' as event_di;
import 'package:karate_stars_app/src/home/home_di.dart' as home_di;
import 'package:karate_stars_app/src/news/news_di.dart' as news_di;
import 'package:karate_stars_app/src/rankings/rankings_di.dart' as rankings_di;
import 'package:karate_stars_app/src/rate_app/rate_app_di.dart' as rate_app_di;
import 'package:karate_stars_app/src/search/search_di.dart' as search_di;
import 'package:karate_stars_app/src/settings/settings_di.dart' as settings_di;
import 'package:karate_stars_app/src/videos/videos_di.dart' as videos_di;
import 'package:karate_stars_app/src/purchases/purchases_di.dart' as purchases_di;

final getIt = GetIt.instance;

int largeCacheTimeMillis = const Duration(days: 7).inMilliseconds;
int mediumCacheTimeMillis = const Duration(hours: 4).inMilliseconds;
int smallCacheTimeMillis = const Duration(minutes: 10).inMilliseconds;

Future<void> init() async {
  getIt.allowReassignment = true;
  getIt.registerLazySingleton<AnalyticsService>(
          () => FirebaseAnalyticsService());

  final database = await Database.create();

  final apiBaseAddress = dotenv.env['API_URL'] ?? '';
  final username = dotenv.env['API_USERNAME'] ?? '';
  final password = dotenv.env['API_PASSWORD'] ?? '';

  if (apiBaseAddress.isEmpty || username.isEmpty || password.isEmpty)
    throw Exception(
        'URL or environment variables for api credentials are not configured');

  final Credentials apiCredentials = Credentials(username, password);

  getIt.registerLazySingleton<ApiTokenStorage>(() => ApiTokenSecureStorage());

  home_di.initAll();
  news_di.initAll(database, apiBaseAddress, apiCredentials);
  competitors_di.initAll(database, apiBaseAddress, apiCredentials);
  videos_di.initAll(database, apiBaseAddress, apiCredentials);
  countries_di.initAll(database, apiBaseAddress, apiCredentials);
  category_di.initAll(database, apiBaseAddress, apiCredentials);
  category_types_di.initAll(database, apiBaseAddress, apiCredentials);
  event_di.initAll(database, apiBaseAddress, apiCredentials);
  event_types_di.initAll(database, apiBaseAddress, apiCredentials);
  settings_di.initAll(apiBaseAddress, apiCredentials);
  search_di.initAll(apiBaseAddress, apiCredentials);
  rate_app_di.initAll(apiCredentials);
  rankings_di.initAll(database, apiBaseAddress, apiCredentials);
  purchases_di.initAll(apiBaseAddress, apiCredentials);
}

void initWithoutDataDependencies() {
  getIt.allowReassignment = true;
  getIt.registerLazySingleton<AnalyticsService>(
          () => FakeAnalyticsService());

  home_di.initBlocAndUseCases();
  news_di.initBlocAndUseCases();
  competitors_di.initBlocAndUseCases();
  videos_di.initBlocAndUseCases();
  countries_di.initBlocAndUseCases();
  category_di.initBlocAndUseCases();
  category_types_di.initBlocAndUseCases();
  event_di.initBlocAndUseCases();
  event_types_di.initBlocAndUseCases();
  settings_di.initBlocAndUseCases();
  search_di.initBlocAndUseCases();
  rate_app_di.initUseCases();
  rankings_di.initBlocAndUseCases();
}

Future<void> reset() {
  return getIt.reset();
}
