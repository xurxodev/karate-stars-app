import 'package:get_it/get_it.dart';
import 'package:karate_stars_app/src/browser/browser_di.dart' as browser_di;
import 'package:karate_stars_app/src/common/data/database.dart';
import 'package:karate_stars_app/src/news/news_di.dart' as news_di;

final getIt = GetIt.instance;

int largeCacheTimeMillis = const Duration(days: 7).inMilliseconds;
int mediumCacheTimeMillis = const Duration(hours: 4).inMilliseconds;
int smallCacheTimeMillis = const Duration(hours: 1).inMilliseconds;

Future<void> init(AppDatabase appDatabase) async {
  news_di.init(appDatabase);
  browser_di.init();
}
