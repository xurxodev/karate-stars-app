abstract class AnalyticsService {
  void sendScreenName(String name);
  void sendEvent(AnalyticsEvent event);
}
abstract class AnalyticsEvent {
  final String name;
  final params = <String, dynamic>{};

  AnalyticsEvent(this.name);
}
