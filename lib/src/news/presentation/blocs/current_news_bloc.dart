import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/states/option.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/news/domain/get_news_use_case.dart';
import 'package:karate_stars_app/src/news/domain/news_filter.dart';
import 'package:karate_stars_app/src/news/presentation/states/news_state.dart';

class CurrentNewsBloc extends Bloc<NewsState> {
  static const screen_name = 'top_news';
  final GetNewsUseCase _getNewsUseCase;
  final AnalyticsService _analyticsService;

  List<Option> typeOptions = [];

  CurrentNewsBloc(this._getNewsUseCase, this._analyticsService) {
    _analyticsService.sendScreenName(screen_name);
    changeState(NewsState(listState: DefaultState.loading()));
    _loadData(ReadPolicy.cache_first);
  }

  void refresh() {
    _loadData(ReadPolicy.network_first);
  }

  Future<void> _loadData(ReadPolicy readPolicy) async {
    try {
      final news = await _getNewsUseCase.execute(
          readPolicy, NewsFilter(type: NewsType.current));

      changeState(state.copyWith(listState: DefaultState.loaded(news)));
    } on Exception {
      changeState(state.copyWith(
          listState: DefaultState.error(Strings.network_error_message)));
    }
  }
}
