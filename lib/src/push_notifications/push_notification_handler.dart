import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/functions/show_local_notifications.dart';
import 'package:karate_stars_app/src/common/presentation/functions/url.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/competitors/presentation/pages/competitor_detail_page.dart';
import 'package:karate_stars_app/src/rankings/domain/get_ranking_by_id.dart';
import 'package:karate_stars_app/src/rankings/presentation/pages/rankings_categories_page.dart';
import 'package:karate_stars_app/src/settings/presentation/blocs/settings_bloc.dart';
import 'package:karate_stars_app/src/settings/presentation/states/settings_state.dart';
import 'package:karate_stars_app/src/videos/presentation/pages/video_player_page.dart';

class PushNotificationsHandler extends StatefulWidget {
  final Widget child;

  const PushNotificationsHandler({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _PushNotificationsHandlerState createState() =>
      _PushNotificationsHandlerState();
}

class _PushNotificationsHandlerState extends State<PushNotificationsHandler> {
  static const String _urlTopic = 'url_notification';
  static const String _competitorTopic = 'competitor_notification';
  static const String _videoTopic = 'video_notification';
  static const String _rankingTopic = 'ranking_notification';
  static const String _debugUrlTopic = 'debug_url_notification';
  static const String _debugCompetitorTopic = 'debug_competitor_notification';
  static const String _debugVideoTopic = 'debug_video_notification';
  static const String _debugRankingTopic = 'debug_ranking_notification';

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  StreamSubscription<SettingsState>? _subscription;

  @override
  void initState() {
    super.initState();

    final bloc = BlocProvider.of<SettingsBloc>(context);

    print(bloc.state);

    _subscription = bloc.observableState.listen((event) {
      if (event is LoadedState) {
        final settingsState = event as LoadedState<SettingsStateData>;
        _updateSubscriptionsToTopics(settingsState.data);
      }
    });

    _initializePushNotificationsListeners();

    final settingsState = bloc.state as LoadedState<SettingsStateData>;
    _updateSubscriptionsToTopics(settingsState.data);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future<void> _initializePushNotificationsListeners() async {
    _requestPermission();

/*    final token = await _firebaseMessaging.getToken();
    print('Token: $token');*/

    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    _firebaseMessaging.getInitialMessage().then(_onInitialMessage);
  }

  Future<void> _updateSubscriptionsToTopics(SettingsStateData state) async {
    if (state.newsNotification) {
      print('subscribe news');
      _firebaseMessaging.subscribeToTopic(_urlTopic);

      if (!kReleaseMode) {
        _firebaseMessaging.subscribeToTopic(_debugUrlTopic);
      }
    } else {
      print('unsubscribe news');
      _firebaseMessaging.unsubscribeFromTopic(_urlTopic);
      _firebaseMessaging.unsubscribeFromTopic(_debugUrlTopic);
    }

    if (state.competitorNotification) {
      print('subscribe competitors');
      _firebaseMessaging.subscribeToTopic(_competitorTopic);

      if (!kReleaseMode) {
        _firebaseMessaging.subscribeToTopic(_debugCompetitorTopic);
      }
    } else {
      print('unsubscribe competitors');
      _firebaseMessaging.unsubscribeFromTopic(_competitorTopic);
      _firebaseMessaging.unsubscribeFromTopic(_debugCompetitorTopic);
    }

    if (state.videoNotification) {
      print('subscribe videos');
      _firebaseMessaging.subscribeToTopic(_videoTopic);

      if (!kReleaseMode) {
        _firebaseMessaging.subscribeToTopic(_debugVideoTopic);
      }
    } else {
      print('unsubscribe videos');
      _firebaseMessaging.unsubscribeFromTopic(_videoTopic);
      _firebaseMessaging.unsubscribeFromTopic(_debugVideoTopic);
    }

    if (state.rankingNotification) {
      print('subscribe rankings');
      _firebaseMessaging.subscribeToTopic(_rankingTopic);

      if (!kReleaseMode) {
        _firebaseMessaging.subscribeToTopic(_debugRankingTopic);
      }
    } else {
      print('unsubscribe rankings');
      _firebaseMessaging.unsubscribeFromTopic(_rankingTopic);
      _firebaseMessaging.unsubscribeFromTopic(_debugRankingTopic);
    }
  }

  Future<void> _onMessageHandler(RemoteMessage message) async {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    print(
        'Message notification: ${message.notification!.title} - ${message.notification!.body}');

    showLocalNotification(context, message, onTap: () {
      _handleNotificationClick(message);
    });
  }

  Future<void> _onMessageOpenApp(RemoteMessage message) async {
    print('Open to click in notification!');
    print('Message data: ${message.data}');
    print(
        'Message notification: ${message.notification!.title} - ${message.notification!.body}');

    _handleNotificationClick(message);
  }

  Future<void> _onInitialMessage(RemoteMessage? message) async {
    print('Handling a on initial message');

    if (message != null) {
      print('Message data: ${message.data}');
      print(
          'Message notification: ${message.notification!.title} - ${message.notification!.body}');

      _handleNotificationClick(message);
    }
  }

  Future<void> _handleNotificationClick(RemoteMessage message) async {
    if (message.data.containsKey('url')) {
      launchURL(context, message.data['url']);
    } else if (message.data.containsKey('competitorId')) {
      CompetitorDetailPage.navigate(context,
          arguments: CompetitorDetailArgs(
              competitorId: message.data['competitorId'],
              readPolicy: ReadPolicy.network_first));
    } else if (message.data.containsKey('videoId')) {
      VideoPlayerPage.navigate(context,
          arguments: VideoPlayerPageArgs(
              videoId: message.data['videoId'],
              readPolicy: ReadPolicy.network_first));
    } else if (message.data.containsKey('rankingId')) {
      final getRankingByIdUseCase = app_di.getIt<GetRankingByIdUseCase>();

      final ranking = await getRankingByIdUseCase.execute(
          ReadPolicy.network_first, message.data['rankingId']);

      if (ranking.apiUrl == null) {
        launchURL(context, ranking.webUrl);
      } else {
        final args = RankingCategoriesArgs(
            rankingId: ranking.id, readPolicy: ReadPolicy.network_first);
        RankingCategoriesPage.navigate(context, arguments: args);
      }
    }
  }

  // Apple / Web
  Future<void> _requestPermission() async {
    final NotificationSettings settings =
        await _firebaseMessaging.requestPermission(
            alert: true,
            announcement: false,
            badge: true,
            carPlay: false,
            criticalAlert: false,
            provisional: false,
            sound: true);

    print('User push notification status ${settings.authorizationStatus}');
  }

  @override
  void dispose() {
    if (_subscription != null) {
      _subscription?.cancel();
      _subscription = null;
    }
    super.dispose();
  }
}
