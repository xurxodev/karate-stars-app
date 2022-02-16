import 'dart:async';

import 'package:karate_stars_app/src/common/analytics/events.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_home_list_content.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/states/option.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/competitors/domain/get_competitors_use_case.dart';
import 'package:karate_stars_app/src/videos/domain/get_videos_use_case.dart';
import 'package:karate_stars_app/src/videos/domain/videos_filter.dart';
import 'package:karate_stars_app/src/videos/presentation/states/videos_filter_state.dart';
import 'package:karate_stars_app/src/videos/presentation/states/videos_state.dart';

class VideosBloc extends BlocHomeListContent<VideosState> {
  static const screen_name = 'home_videos';
  final GetVideosUseCase _getVideosUseCase;
  final GetCompetitorsUseCase _getCompetitorsUseCase;

  final defaultCompetitor = Option.defaultOption();
  final defaultYear = Option.defaultOption();

  List<Option> competitorsOptions = [];
  List<Option> yearOptions = [];

  VideosBloc(this._getVideosUseCase, this._getCompetitorsUseCase,
      AnalyticsService _analyticsService)
      : super(_analyticsService, screen_name) {
    changeState(VideosState(
        list: DefaultState.loading(),
        filters: VideosFilterState(
            competitorOptions: [],
            yearOptions: [],
            selectedCompetitor: defaultCompetitor.id,
            selectedYear: defaultYear.id)));

    _loadMetadataAndData(ReadPolicy.cache_first);
  }

  Future<void> refresh() {
    return _loadData(ReadPolicy.network_first);
  }

  void filter({String? selectedCompetitor, String? selectedYear}) {
    final filters = state.filters.copyWith(
        selectedCompetitor:
            selectedCompetitor ?? state.filters.selectedCompetitor,
        selectedYear: selectedYear ?? state.filters.selectedYear);

    _sendFilterEvent(filters);

    changeState(state.copyWith(filters: filters));

    _loadData(ReadPolicy.cache_first);
  }

  void _sendFilterEvent(VideosFilterState filters) {
    final competitorFilter = competitorsOptions
        .firstWhere((option) => option.id == filters.selectedCompetitor);
    final yearFilter =
        yearOptions.firstWhere((option) => option.id == filters.selectedYear);

    final filter =
        'competitor: ${competitorFilter.name} year: ${yearFilter.name}}';
    super.analyticsService.sendEvent(VideosFilterEvent(filter));
  }

  Future<void> _loadMetadataAndData(ReadPolicy readPolicy) async {
    try {
      await _loadMetadata(readPolicy);
      await _loadData(readPolicy);
    } on Exception {
      changeState(state.copyWith(
          list: DefaultState.error(Strings.network_error_message)));
    }
  }

  Future<void> _loadMetadata(ReadPolicy readPolicy) async {
    competitorsOptions = [
      defaultCompetitor,
      ...(await _getCompetitorsUseCase.execute(readPolicy))
          .map((item) => Option(item.id, item.fullName()))
    ];

    final videos = await _getVideosUseCase.execute(readPolicy, VideosFilter());
    final options = videos.map((video) => Option(
        video.eventDate.year.toString(), video.eventDate.year.toString()));
    final finalOptions = options.toSet().toList();

    yearOptions = [defaultCompetitor, ...finalOptions];
  }

  Future<void> _loadData(ReadPolicy readPolicy) async {
    try {
      final year = Option.getIdOrNull(state.filters.selectedYear);

      final videosFilter = VideosFilter(
          competitorId: Option.getIdOrNull(state.filters.selectedCompetitor),
          year: year != null ? int.parse(year) : null);

      final videos = await _getVideosUseCase.execute(readPolicy, videosFilter);

      changeState(state.copyWith(
          list: DefaultState.loaded(videos),
          filters: state.filters.copyWith(
              competitorOptions: competitorsOptions,
              yearOptions: yearOptions)));
    } on Exception {
      changeState(state.copyWith(
          list: DefaultState.error(Strings.network_error_message)));
    }
  }
}
