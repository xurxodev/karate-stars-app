import 'dart:async';
import 'package:collection/collection.dart';
import 'package:karate_stars_app/src/common/analytics/events.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_searchable.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/presentation/states/option.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/competitors/domain/competitors_filter.dart';
import 'package:karate_stars_app/src/competitors/domain/get_competitors_use_case.dart';
import 'package:karate_stars_app/src/competitors/presentation/states/competitors_state.dart';
import 'package:karate_stars_app/src/countries/domain/entities/country.dart';
import 'package:karate_stars_app/src/countries/domain/get_countries_use_case.dart';
import 'package:karate_stars_app/src/news/domain/get_news_use_case.dart';
import 'package:karate_stars_app/src/news/domain/news_filter.dart';
import 'package:karate_stars_app/src/search/presentation/states/search_state.dart';
import 'package:karate_stars_app/src/videos/domain/get_videos_use_case.dart';
import 'package:karate_stars_app/src/videos/domain/videos_filter.dart';

class SearchBloc extends BlocSearchable<SearchState> {
  static const screen_name = 'search';

  final GetNewsUseCase _getNewsUseCase;
  final GetCompetitorsUseCase _getCompetitorsUseCase;
  final GetVideosUseCase _getVideosUseCase;
  final GetCountriesUseCase _getCountriesUseCase;

  List<Country> countries = [];

  final AnalyticsService _analyticsService;

  List<Option> brightnessOptions = [];

  SearchBloc(
      this._getNewsUseCase,
      this._getCompetitorsUseCase,
      this._getVideosUseCase,
      this._getCountriesUseCase,
      this._analyticsService) {
    changeState(SearchState.searching());

    _analyticsService.sendScreenName('$screen_name');

    _loadMetadataAndSearch(ReadPolicy.cache_first);
  }

  Future<void> _loadMetadataAndSearch(ReadPolicy readPolicy) async {
    countries = await _getCountriesUseCase.execute(readPolicy);
    search('');
  }

  @override
  Future<void> executeSearch(String searchTerm) async {
    try {
      _sendSearchToAnalytics(searchTerm);

      final newsResults = await _getNewsUseCase.execute(ReadPolicy.cache_first,
          NewsFilter(type: NewsType.all, searchTerm: searchTerm));

      final competitors = await _getCompetitorsUseCase.execute(
          ReadPolicy.cache_first,
          competitorsFilter: CompetitorsFilter(searchTerm: searchTerm));

      final competitorResults = competitors.map((competitor) {
        final country = countries
            .firstWhereOrNull((country) => country.id == competitor.countryId);

        return CompetitorItemState(
            competitor.id,
            '${competitor.firstName} ${competitor.lastName}',
            competitor.mainImage,
            country?.image ?? '');
      }).toList();

      final videosResults = await _getVideosUseCase.execute(
          ReadPolicy.cache_first, VideosFilter(searchTerm: searchTerm));

      final searchStateData = SearchStateData(
          newsResults: newsResults,
          competitorResults: competitorResults,
          videosResults: videosResults);

      changeState(SearchState.results(searchStateData));
    } on Exception {
      changeState(SearchState.error(Strings.network_error_message));
    }
  }

  void _sendSearchToAnalytics(String query) {
    if (query.length > 3) {
      _analyticsService.sendEvent(SearchEvent(query));
    }
  }
}
