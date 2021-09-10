import 'package:karate_stars_app/src/common/strings.dart';

class NewsFilterState {
  final Map<int, String> filterOptions = {
    0: Strings.default_filters_all,
    1: Strings.news_filters_current,
    2: Strings.news_filters_social
  };

  final int selectedIndex;

  NewsFilterState({this.selectedIndex = 0});
}
