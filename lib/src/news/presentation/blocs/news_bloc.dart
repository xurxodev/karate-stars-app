import 'package:karate_stars_app/src/common/analytics/events.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_home_list_content.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/news/domain/get_news_use_case.dart';
import 'package:karate_stars_app/src/news/domain/news_filter.dart';
import 'package:karate_stars_app/src/news/presentation/states/news_filter_state.dart';
import 'package:karate_stars_app/src/news/presentation/states/news_state.dart';

class NewsBloc extends BlocHomeListContent<NewsState> {
  static const screen_name = 'home_news';
  final GetNewsUseCase _getNewsUseCase;

  NewsBloc(this._getNewsUseCase, AnalyticsService _analyticsService)
      : super(_analyticsService, screen_name) {
    changeState(NewsState(
        listState: DefaultState.loading(), filtersState: NewsFilterState()));
    _loadData(ReadPolicy.cache_first);
  }

  void refresh() {
    _loadData(ReadPolicy.network_first);
  }

  void filter(int selectedIndex) {
    final NewsFilter selectedFilter = NewsFilter.values[selectedIndex];

    final filter = selectedFilter.toString().split('.')[1];
    super.analyticsService.sendEvent(NewsFilterEvent(filter));

    changeState(state.copyWith(
        filtersState: NewsFilterState(selectedIndex: selectedIndex)));

    _loadData(ReadPolicy.cache_first);
  }

  void _loadData(ReadPolicy readPolicy) {
    final NewsFilter selectedFilter =
        NewsFilter.values[state.filtersState.selectedIndex];

    _getNewsUseCase.execute(readPolicy, selectedFilter).then((news) {
      changeState(state.copyWith(listState: DefaultState.loaded(news)));
    }).catchError((error) {
      changeState(state.copyWith(
          listState: DefaultState.error(Strings.network_error_message)));
    });
  }
}
