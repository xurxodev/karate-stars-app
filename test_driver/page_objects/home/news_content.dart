import 'package:flutter_driver/flutter_driver.dart';

class NewsContent {
  NewsContent(this.driver);

  FlutterDriver driver;

  final newsPageViewFinder = find.byValueKey('news_page_view');

  Future<void> isVisible({Duration timeout}) => driver.waitFor(newsPageViewFinder);

}