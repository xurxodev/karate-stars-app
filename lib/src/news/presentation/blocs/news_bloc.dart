import 'dart:async';

import 'package:karate_stars_app/src/common/analytics/events.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_home_list_content.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/news/domain/get_news_use_case.dart';
import 'package:karate_stars_app/src/news/domain/news_filter.dart';
import 'package:karate_stars_app/src/news/presentation/states/news_filter_state.dart';
import 'package:karate_stars_app/src/news/presentation/states/news_state.dart';

class NewsBloc extends BlocHomeListContent {
  static const screen_name = 'home_news';
  final GetNewsUseCase _getNewsUseCase;

  NewsFilterState _lastFilter = NewsFilterState();
  NewsState _lastNewsState;

  final _newsFilterController = StreamController<NewsFilterState>.broadcast();
  final _newsController = StreamController<NewsState>.broadcast();

  NewsBloc(this._getNewsUseCase, AnalyticsService _analyticsService)
      : super(_analyticsService, screen_name) {
    _loadDataCacheFirst(NewsFilter.all);
    _listenFilters();
  }

  NewsFilterState get initialFilter => _lastFilter;

  Stream<NewsFilterState> get filter => _newsFilterController.stream;

  StreamSink<NewsFilterState> get filterSink => _newsFilterController.sink;

  NewsState get initialNews => _lastNewsState;

  Stream<NewsState> get news => _newsController.stream;

  @override
  void dispose() {
    _newsController.close();
    _newsFilterController.close();
  }

  Future<void> refresh() {
    final NewsFilter selectedFilter =
        NewsFilter.values[_lastFilter.selectedIndex];

    return _getNewsUseCase
        .execute(ReadPolicy.network_first, selectedFilter)
        .then((news) {
      _lastNewsState = NewsState.loaded(news);
      _newsController.sink.add(_lastNewsState);
    }).catchError((error) {
      _lastNewsState = NewsState.error(Strings.network_error_message);
      _newsController.sink.add(_lastNewsState);
    });
  }

  void _loadDataCacheFirst(NewsFilter newsFilter) {
    _lastNewsState = NewsState.loading();
    _newsController.sink.add(_lastNewsState);

    _getNewsUseCase.execute(ReadPolicy.cache_first, newsFilter).then((news) {
      _lastNewsState = NewsState.loaded(news);
      _newsController.sink.add(_lastNewsState);
    }).catchError((error) {
      _lastNewsState = NewsState.error(Strings.network_error_message);
      _newsController.sink.add(_lastNewsState);
    });
  }

  void _listenFilters() {
    _newsFilterController.stream.listen((filterState) {
      _lastFilter = filterState;
      final NewsFilter selectedFilter =
          NewsFilter.values[filterState.selectedIndex];


      final filter = selectedFilter.toString().split('.')[1];
      super.analyticsService.sendEvent(NewsFilterEvent(filter));

      _loadDataCacheFirst(selectedFilter);
    });
  }
}
