import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_home_list_content.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/states/option.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/home/presentation/states/home_state.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/get_news_use_case.dart';
import 'package:karate_stars_app/src/news/domain/news_filter.dart';
import 'package:karate_stars_app/src/videos/domain/get_videos_use_case.dart';
import 'package:karate_stars_app/src/videos/domain/videos_filter.dart';

class HomeBloc extends BlocHomeListContent<HomeState> {
  static const screen_name = 'home_news';
  final GetNewsUseCase _getNewsUseCase;
  final GetVideosUseCase _getVideosUseCase;

  List<Option> typeOptions = [];

  HomeBloc(this._getNewsUseCase, this._getVideosUseCase,
      AnalyticsService _analyticsService)
      : super(_analyticsService, screen_name) {
    changeState(HomeState(
        listState: DefaultState.loading()));
    _loadData(ReadPolicy.cache_first);
  }

  void refresh() {
    _loadData(ReadPolicy.network_first);
  }

  Future<void> _loadData(ReadPolicy readPolicy) async {
    try {
      final homeSocialNews = (await _getNewsUseCase.execute(
              readPolicy, NewsFilter(type: NewsType.social)))
          .map((newsItem) => HomeItem.news(newsItem))
          .toList();

      final lastVideos =
          await _getVideosUseCase.execute(readPolicy, VideosFilter(count: 4));

      final homeLastVideosItem =lastVideos.isNotEmpty ? HomeItem.lastVideos(lastVideos):null;

      final lastCurrentNews = (await _getNewsUseCase.execute(
              readPolicy, NewsFilter(type: NewsType.current, count: 5)))
          .map((news) => news as CurrentNews)
          .toList();

      final homeTopNews =lastCurrentNews.isNotEmpty? HomeItem.topNews(lastCurrentNews):null;

      final finalHomeItems= [
        homeTopNews,
        homeLastVideosItem,
        ...homeSocialNews
      ].whereType<HomeItem>().toList();

      changeState(
          state.copyWith(listState: DefaultState.loaded(finalHomeItems)));
    } on Exception {
      changeState(state.copyWith(
          listState: DefaultState.error(Strings.network_error_message)));
    }
  }
}
