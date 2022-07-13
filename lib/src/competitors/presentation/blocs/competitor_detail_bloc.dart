import 'dart:async';
import 'package:collection/collection.dart';
import 'package:karate_stars_app/src/categories/domain/get_categories.dart';
import 'package:karate_stars_app/src/common/analytics/events.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/competitors/domain/get_competitor_by_id_use_case.dart';
import 'package:karate_stars_app/src/competitors/presentation/states/competitor_detail_state.dart';
import 'package:karate_stars_app/src/event_types/domain/get_event_types.dart';
import 'package:karate_stars_app/src/events/domain/events_filter.dart';
import 'package:karate_stars_app/src/events/domain/get_events.dart';
import 'package:karate_stars_app/src/rate_app/domain/usecases/get_rate_app_use_case.dart';
import 'package:karate_stars_app/src/rate_app/presentation/utils.dart';

class CompetitorDetailBloc extends Bloc<CompetitorDetailState> {
  static const screen_name = 'competitor_detail';
  final GetCompetitorByIdUseCase _getCompetitorByIdUseCase;
  final GetEventTypesUseCase _getEventTypesUseCase;
  final GetEventsUseCase _getEventsUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  final GetRateAppUseCase _getRateAppUseCase;

  final AnalyticsService _analyticsService;

  CompetitorDetailBloc(
      this._getCompetitorByIdUseCase,
      this._getEventTypesUseCase,
      this._getEventsUseCase,
      this._getCategoriesUseCase,
      this._getRateAppUseCase,
      this._analyticsService) {
    changeState(CompetitorDetailState(competitor: DefaultState.loading()));
  }

  void init(
      {required String competitorId,
      ReadPolicy readPolicy = ReadPolicy.cache_first}) {
    increaseAppRateConversionCount();
    _loadData(competitorId, readPolicy);
  }

  Future<void> _loadData(String competitorId, ReadPolicy readPolicy) async {
    try {
      final competitor =
          await _getCompetitorByIdUseCase.execute(readPolicy, competitorId);
      final eventTypes = await _getEventTypesUseCase.execute(readPolicy);
      final events =
          await _getEventsUseCase.execute(readPolicy, EventsFilters());
      final categories = await _getCategoriesUseCase.execute(readPolicy);

      _analyticsService.sendScreenName('$screen_name/${competitor.id}');

      final achievementsByEventType =
          competitor.achievements.groupListsBy((achievement) {
        final event =
            events.firstWhere((event) => event.id == achievement.eventId);

        return eventTypes
            .firstWhere((eventType) => eventType.id == event.typeId)
            .name;
      });

      final eventTypeNames = achievementsByEventType.keys.toList();
      eventTypeNames.sort((a,b) => a.compareTo(b));

      final finalAchievements = Map.fromIterable(eventTypeNames, key: (key) => key as String, value: (key) {
        final mappedAchievements =
        achievementsByEventType[key]!.map((achievement) {
          final event =
          events.firstWhere((event) => event.id == achievement.eventId);

          final category = categories
              .firstWhere((category) => category.id == achievement.categoryId);

          return AchievementState(event.name, category.name, achievement.position);
        }).toList();

        return mappedAchievements;
      });


      final competitorInfo = CompetitorInfoState(
          competitor.id,
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

      changeState(CompetitorDetailState(
          competitor: DefaultState.loaded(competitorInfo)));
    } on Exception {
      changeState(CompetitorDetailState(
          competitor: DefaultState.error(Strings.network_error_message)));
    }
  }

  Future<void> onEnd() async {
    print('Reached the bottom');
    final rateApp = await _getRateAppUseCase.execute();
    if (await rateApp.isRequestRateAppRequired()) {
      print('Request review required');
      changeState(state.copyWith(requestRateApp: true));
      updateAppRateLastRequestVersion();
      _analyticsService.sendEvent(RateApp(RateAppFrom.fromAlgorithm));
    }
  }
}
