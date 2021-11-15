import 'package:karate_stars_app/src/common/analytics/events.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_home_list_content.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
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

  NewsBloc(this._getNewsUseCase, this._getVideosUseCase,
      AnalyticsService _analyticsService)
      : super(_analyticsService, screen_name) {
    changeState(NewsState(
        listState: DefaultState.loading(), filtersState: NewsFilterState()));
    _loadData(ReadPolicy.cache_first);
  }

  void refresh() {
    _loadData(ReadPolicy.network_first);
  }

  void filter(int selectedIndex) {
    final NewsType selectedFilter = NewsType.values[selectedIndex];

    final filter = selectedFilter.toString().split('.')[1];
    super.analyticsService.sendEvent(NewsFilterEvent(filter));

    changeState(state.copyWith(
        filtersState: NewsFilterState(selectedIndex: selectedIndex)));

    _loadData(ReadPolicy.cache_first);
  }

  Future<void> _loadData(ReadPolicy readPolicy) async {
    try {
      final NewsFilter selectedFilter =
          NewsFilter(type: NewsType.values[state.filtersState.selectedIndex]);

      final news = await _getNewsUseCase.execute(readPolicy, selectedFilter);

      final liveVideos = await _getVideosUseCase.execute(
          readPolicy, VideosFilter(isLive: true));

      final finalNews = liveVideos.isNotEmpty
          ? [
              News.liveVideoNews(NewsSummary(
                  title: 'Live videos',
                  pubDate: PubDate(DateTime.now())), liveVideos[0].id),
              ...news
            ]
          : news;

      changeState(state.copyWith(listState: DefaultState.loaded(finalNews)));
    } on Exception {
      changeState(state.copyWith(
          listState: DefaultState.error(Strings.network_error_message)));
    }
  }
}
