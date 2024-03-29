import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';

class FirebaseAnalyticsService extends AnalyticsService {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void sendScreenName(String name) {
    analytics.setCurrentScreen(screenName: name);
  }

  @override
  void sendEvent(AnalyticsEvent event) {
    analytics.logEvent(name: event.name, parameters: event.params);
  }
}

class FakeAnalyticsService extends AnalyticsService {

  @override
  void sendScreenName(String name) {

  }

  @override
  void sendEvent(AnalyticsEvent event) {

  }
}
