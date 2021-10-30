import 'dart:async';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/competitors/domain/get_competitor_by_id_use_case.dart';
import 'package:karate_stars_app/src/videos/domain/get_videos_use_case.dart';
import 'package:karate_stars_app/src/videos/domain/videos_filter.dart';
import 'package:karate_stars_app/src/videos/presentation/states/competitor_videos_state.dart';

class CompetitorVideosBloc extends Bloc<CompetitorVideosState> {
  static const screen_name = 'competitor_videos';
  final GetCompetitorByIdUseCase _getCompetitorByIdUseCase;
  final GetVideosUseCase _getVideosUseCase;

  final AnalyticsService _analyticsService;

  CompetitorVideosBloc(this._getCompetitorByIdUseCase, this._getVideosUseCase,
      this._analyticsService) {
    changeState(DefaultState.loading());
  }

  void init(String competitorId) {
    _loadData(competitorId);
  }

  Future<void> _loadData(String competitorId) async {
    try {
      final competitor = await _getCompetitorByIdUseCase.execute(
          ReadPolicy.cache_first, competitorId);
      final videos = await _getVideosUseCase.execute(
          ReadPolicy.cache_first, VideosFilter(competitorId: competitorId));

      _analyticsService.sendScreenName('$screen_name/${competitor.identifier}');

      final competitorInfo = CompetitorVideos(competitor.identifier,
          competitor.fullName(), competitor.mainImage, videos);

      changeState(DefaultState.loaded(competitorInfo));
    } on Exception {
      changeState(DefaultState.error(Strings.network_error_message));
    }
  }
}
