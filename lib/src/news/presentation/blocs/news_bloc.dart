import 'package:karate_stars_app/src/common/analytics/events.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_home_list_content.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/states/option.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';
import 'package:karate_stars_app/src/news/domain/entities/summary.dart';
import 'package:karate_stars_app/src/news/domain/get_news_use_case.dart';
import 'package:karate_stars_app/src/news/domain/news_filter.dart';
import 'package:karate_stars_app/src/news/presentation/states/news_filter_state.dart';
import 'package:karate_stars_app/src/news/presentation/states/news_state.dart';
import 'package:karate_stars_app/src/videos/domain/get_videos_use_case.dart';
import 'package:karate_stars_app/src/videos/domain/videos_filter.dart';

class NewsBloc extends BlocHomeListContent<NewsState> {
  static const screen_name = 'home_news';
  final GetNewsUseCase _getNewsUseCase;
  final GetVideosUseCase _getVideosUseCase;

  List<Option> typeOptions = [];

  NewsBloc(this._getNewsUseCase, this._getVideosUseCase,
      AnalyticsService _analyticsService)
      : super(_analyticsService, screen_name) {
    final typeOptions = mapNewsTypeToOptions();

    changeState(NewsState(
        listState: DefaultState.loading(),
        filtersState: NewsFilterState(
            typeOptions: typeOptions, selectedType: typeOptions[0].id)));
    _loadData(ReadPolicy.cache_first);
  }

  void refresh() {
    _loadData(ReadPolicy.network_first);
  }

  void filter(String selectedType) {
    _sendFilterEvent(selectedType);

    changeState(state.copyWith(
        filtersState: state.filtersState.copyWith(selectedType: selectedType)));

    _loadData(ReadPolicy.cache_first);
  }

  void _sendFilterEvent(String selectedType) {
    final selectedFilter =
        NewsType.values.firstWhere((item) => item.name == selectedType);

    final filter = selectedFilter.toString().split('.')[1];
    super.analyticsService.sendEvent(NewsFilterEvent(filter));
  }

  Future<void> _loadData(ReadPolicy readPolicy) async {
    try {
      final NewsFilter selectedFilter = NewsFilter(
          type: NewsType.values.firstWhere(
              (item) => item.name == state.filtersState.selectedType));

      final news = await _getNewsUseCase.execute(readPolicy, selectedFilter);

      final liveVideos = await _getVideosUseCase.execute(
          readPolicy, VideosFilter(isLive: true));

      final finalNews = liveVideos.isNotEmpty
          ? [
              News.liveVideoNews(
                  NewsSummary(
                      title: 'Live videos', pubDate: PubDate(DateTime.now())),
                  liveVideos[0].id),
              ...news
            ]
          : news;

      changeState(state.copyWith(listState: DefaultState.loaded(finalNews)));
    } on Exception {
      changeState(state.copyWith(
          listState: DefaultState.error(Strings.network_error_message)));
    }
  }

  List<Option> mapNewsTypeToOptions() {
    return NewsType.values.map((item) {
      switch (item) {
        case NewsType.all:
          return Option(NewsType.all.name, Strings.default_filters_all);
        case NewsType.social:
          return Option(NewsType.social.name, Strings.news_filters_social);
        case NewsType.current:
          return Option(NewsType.current.name, Strings.news_filters_current);
      }
    }).toList();
  }
}
