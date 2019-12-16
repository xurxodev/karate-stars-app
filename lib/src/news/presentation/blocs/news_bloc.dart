import 'dart:async';

import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_base.dart';
import 'package:karate_stars_app/src/news/domain/get_news_use_case.dart';
import 'package:karate_stars_app/src/news/domain/news_filter.dart';
import 'package:karate_stars_app/src/news/presentation/states/news_state.dart';

class NewsBloc implements BlocBase {
  final GetNewsUseCase _getNewsUseCase;

  //final _newsFilterController = StreamController<NewsFilter>.broadcast();
  final _newsController = StreamController<NewsState>.broadcast();

  NewsBloc(this._getNewsUseCase){
    _loadData(ReadPolicy.cache_first, NewsFilter.all);
  }

  //StreamSink<String> get query => _queryController.sink;

  NewsState _news = NewsState.loading();
  Stream<NewsState> get news => _newsController.stream;
  NewsState get initialState => _news;

  void _loadData(ReadPolicy readPolicy, NewsFilter newsFilter) {
    _getNewsUseCase.execute(readPolicy, newsFilter).then((news) {
      _news = NewsState.loaded(news);
      _newsController.sink.add(_news);
    }).catchError((error) {
      _newsController.sink.addError(error);
    });
  }

  @override
  void dispose() {
    _newsController.close();
    //_newsFilterController.close();
  }
}
