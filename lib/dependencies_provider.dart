import 'package:get_it/get_it.dart';
import 'package:karate_stars_app/src/news/news_di.dart' as news_di;

final getIt = GetIt.instance;

void init() {
  news_di.init();
}
