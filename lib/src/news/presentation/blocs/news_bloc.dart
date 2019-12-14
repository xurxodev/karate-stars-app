import 'dart:async';

import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_base.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/get_news_use_case.dart';
import 'package:karate_stars_app/src/news/domain/news_filter.dart';

class NewsBloc implements BlocBase {
  final GetNewsUseCase _getNewsUseCase;

  //final _newsFilterController = StreamController<NewsFilter>.broadcast();
  final _newsController = StreamController<List<News>>.broadcast();

  NewsBloc(this._getNewsUseCase) {
    loadData(ReadPolicy.cache_first, NewsFilter.all);
  }

  Stream<List<News>> get news => _newsController.stream;

  void loadData(ReadPolicy readPolicy, NewsFilter newsFilter) {
    _getNewsUseCase.execute(readPolicy, newsFilter).then((news) {
      print(news);
      _newsController.sink.add(news);
    }).catchError((error) {
      print(error);
      _newsController.sink.addError(error);
    });
  }

  @override
  void dispose() {
    _newsController.close();
    //_newsFilterController.close();
  }
}
