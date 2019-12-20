import 'dart:async';

import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_base.dart';
import 'package:karate_stars_app/src/news/domain/get_news_use_case.dart';
import 'package:karate_stars_app/src/news/domain/news_filter.dart';
import 'package:karate_stars_app/src/news/presentation/states/news_filter_state.dart';
import 'package:karate_stars_app/src/news/presentation/states/news_state.dart';

class NewsBloc implements BlocBase {
  final GetNewsUseCase _getNewsUseCase;

  NewsFilterState _lastFilter = NewsFilterState();
  NewsState _lastNews = NewsState.loading();

  final _newsFilterController = StreamController<NewsFilterState>.broadcast();
  final _newsController = StreamController<NewsState>.broadcast();

  NewsBloc(this._getNewsUseCase) {
    _loadData(ReadPolicy.cache_first, NewsFilter.all);
    _listenFilters();
  }

  NewsFilterState get initialFilter => _lastFilter;

  Stream<NewsFilterState> get filter => _newsFilterController.stream;

  StreamSink<NewsFilterState> get filterSink => _newsFilterController.sink;

  NewsState get initialNews => _lastNews;

  Stream<NewsState> get news => _newsController.stream;

  @override
  void dispose() {
    _newsController.close();
    _newsFilterController.close();
  }

  void _loadData(ReadPolicy readPolicy, NewsFilter newsFilter) {
    _getNewsUseCase.execute(readPolicy, newsFilter).then((news) {
      _lastNews = NewsState.loaded(news);
      _newsController.sink.add(_lastNews);
    }).catchError((error) {
      _newsController.sink.addError(error);
    });
  }

  void _listenFilters() {
    _newsFilterController.stream.listen((filterState) {
      _lastFilter = filterState;
      final NewsFilter selectedFilter =
          NewsFilter.values[filterState.selectedIndex];

      _loadData(ReadPolicy.cache_first, selectedFilter);
    });
  }
}
