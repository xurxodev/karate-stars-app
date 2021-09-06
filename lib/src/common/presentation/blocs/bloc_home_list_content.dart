import 'package:flutter/widgets.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';

abstract class BlocHomeListContent<T> extends Bloc<T> {
  @protected
  String screenName;

  @protected
  AnalyticsService analyticsService;

  DateTime? _screenNameLastSentDate;

  BlocHomeListContent(this.analyticsService, this.screenName);

  void registerInteraction() {
    if (_screenNameLastSentDate == null ||
        _screenNameLastSentDate!.difference(DateTime.now()) >=
            const Duration(minutes: 2)) {
      analyticsService.sendScreenName(screenName);
      _screenNameLastSentDate = DateTime.now();
    }
  }
}
