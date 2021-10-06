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

class NewsFilterEvent extends AnalyticsEvent {
  NewsFilterEvent(String newsType) : super('news_filter') {
    params['filters'] = 'type: $newsType';
  }
}

class ShareUrlEvent extends AnalyticsEvent {
  ShareUrlEvent(String url) : super('share') {
    params['content_type'] = 'url';
    params['item_id'] = url;
  }
}

class ChangeSettings extends AnalyticsEvent {
  ChangeSettings(Settings settings, bool value) : super('share') {
    final name = settings.toString().split('.')[1];
    params[name] = value;
  }
}

class ShareApp extends AnalyticsEvent {
  ShareApp(String url) : super('share') {
    params['content_type'] = 'app';
    params['item_id'] = url;
  }
}

class SendEmail extends AnalyticsEvent {
  SendEmail(String email) : super('email') {
    params['method'] = 'email';
    params['destination'] = email;
  }
}

class RateApp extends AnalyticsEvent {
  RateApp() : super('rate_app') {
    params['method'] = 'from_about';
  }
}

enum Settings {
  notifications_competitor,
  notifications_video,
  notifications_news
}
