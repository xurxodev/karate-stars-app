import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';

class SearchEvent extends AnalyticsEvent {
  SearchEvent(String searchTerm) : super('search') {
    params['search_term'] = searchTerm;
  }
}

class CompetitorsFilterEvent extends AnalyticsEvent {
  CompetitorsFilterEvent(String searchTerm) : super('competitors_filter') {
    params['filters'] = searchTerm;
  }
}

class VideosFilterEvent extends AnalyticsEvent {
  VideosFilterEvent(String searchTerm) : super('videos_filter') {
    params['filters'] = searchTerm;
  }
}

class EventsFilterEvent extends AnalyticsEvent {
  EventsFilterEvent(String searchTerm) : super('events_filter') {
    params['filters'] = searchTerm;
  }
}

class NewsFilterEvent extends AnalyticsEvent {
  NewsFilterEvent(String newsType) : super('news_filter') {
    params['filters'] = 'type: $newsType';
  }
}

class ChangeSettings extends AnalyticsEvent {
  ChangeSettings(String name, String value) : super('settings') {
    params[name] = value;
  }
}

class ShareApp extends AnalyticsEvent {
  ShareApp(String url) : super('share') {
    params['content_type'] = 'app';
    params['item_id'] = url;
  }
}

enum RateAppFrom{ fromSettings,fromAlgorithm }

class RateApp extends AnalyticsEvent {
  RateApp(RateAppFrom from) : super('rate_app') {

    if (from == RateAppFrom.fromAlgorithm){
      params['method'] = 'from_algorithm';
    } else {
      params['method'] = 'from_settings';
    }

  }
}
