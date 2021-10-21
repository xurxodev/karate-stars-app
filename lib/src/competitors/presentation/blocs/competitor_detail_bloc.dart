import 'dart:async';
import 'package:collection/collection.dart';
import 'package:karate_stars_app/src/categories/domain/get_categories.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/competitors/domain/get_competitor_by_id_use_case.dart';
import 'package:karate_stars_app/src/competitors/presentation/states/competitor_info_state.dart';
import 'package:karate_stars_app/src/event_types/domain/get_event_types.dart';
import 'package:karate_stars_app/src/events/domain/get_events.dart';

typedef CompetitorDetailState = DefaultState < CompetitorInfoState
>;

class CompetitorDetailBloc extends Bloc<CompetitorDetailState> {
  static const screen_name = 'competitor_detail';
  final GetCompetitorByIdUseCase _getCompetitorByIdUseCase;
  final GetEventTypesUseCase _getEventTypesUseCase;
  final GetEventsUseCase _getEventsUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;

  final AnalyticsService _analyticsService;

  CompetitorDetailBloc(this._getCompetitorByIdUseCase,
      this._getEventTypesUseCase,
      this._getEventsUseCase,
      this._getCategoriesUseCase,
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
      final eventTypes =
      await _getEventTypesUseCase.execute(ReadPolicy.cache_first);
      final events = await _getEventsUseCase.execute(ReadPolicy.cache_first);
      final categories =
      await _getCategoriesUseCase.execute(ReadPolicy.cache_first);

      _analyticsService.sendScreenName('$screen_name/${competitor.identifier}');

      final achievementsByEventType =
      competitor.achievements.groupListsBy((achievement) {
        final event =
        events.firstWhere((event) => event.id == achievement.eventId);

        return eventTypes
            .firstWhere((eventType) => eventType.id == event.typeId)
            .name;
      });

      final finalAchievements = achievementsByEventType.map((key, achievements) {
        final mappedAchievements = achievements.map((achievement) {
          final event =
          events.firstWhere((event) => event.id == achievement.eventId);
          final category = categories
              .firstWhere((category) => category.id == achievement.categoryId);

          return AchievementState(
              event.name, category.name, achievement.position);
        }).toList();

        return MapEntry(
            key, mappedAchievements);
      });

      final competitorInfo = CompetitorInfoState(
          competitor.identifier,
          competitor.firstName,
          competitor.lastName,
          competitor.wkfId,
          competitor.biography,
          competitor.countryId,
          competitor.mainImage,
          competitor.isActive,
          competitor.isLegend,
          competitor.links,
          finalAchievements);

      changeState(DefaultState.loaded(competitorInfo));
    } on Exception {
      changeState(DefaultState.error(Strings.network_error_message));
    }
  }
}
