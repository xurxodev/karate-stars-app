import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/functions/show_local_notifications.dart';
import 'package:karate_stars_app/src/common/presentation/functions/url.dart';
import 'package:karate_stars_app/src/competitors/presentation/pages/competitor_detail_page.dart';
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
  static const String _debugUrlTopic = 'debug_url_notification';
  static const String _debugCompetitorTopic = 'debug_competitor_notification';
  static const String _debugVideoTopic = 'debug_video_notification';

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    initializePushNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future<void> initializePushNotifications() async {
    _requestPermission();

    final token = await _firebaseMessaging.getToken();
    print('Token: $token');

    _firebaseMessaging.subscribeToTopic(_urlTopic);
    _firebaseMessaging.subscribeToTopic(_competitorTopic);
    _firebaseMessaging.subscribeToTopic(_videoTopic);
    _firebaseMessaging.subscribeToTopic(_debugUrlTopic);
    _firebaseMessaging.subscribeToTopic(_debugCompetitorTopic);
    _firebaseMessaging.subscribeToTopic(_debugVideoTopic);

    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    _firebaseMessaging.getInitialMessage().then(_onInitialMessage);
  }

  Future<void> _onMessageHandler(RemoteMessage message) async {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    print(
        'Message notification: ${message.notification!.title} - ${message
            .notification!.body}');

    showLocalNotification(context, message, onTap: () {
      _handleNotificationClick(message);
    });
  }

  Future<void> _onMessageOpenApp(RemoteMessage message) async {
    print('Open to click in notification!');
    print('Message data: ${message.data}');
    print(
        'Message notification: ${message.notification!.title} - ${message
            .notification!.body}');

    _handleNotificationClick(message);
  }

  Future<void> _onInitialMessage(RemoteMessage? message) async {
    print('Handling a on initial message');

    if (message != null){
      print('Message data: ${message.data}');
      print(
          'Message notification: ${message.notification!.title} - ${message
              .notification!.body}');

      _handleNotificationClick(message);
    }
  }

  Future<void> _handleNotificationClick(RemoteMessage message) async {
    if (message.data.containsKey('url')) {
      launchURL(context, message.data['url']);
    } else if (message.data.containsKey('competitorId')) {
      Navigator.pushNamed(context, CompetitorDetailPage.routeName,
          arguments:
          CompetitorDetailArgs(competitorId: message.data['competitorId']));
    } else if (message.data.containsKey('videoId')) {
      Navigator.pushNamed(context, VideoPlayerPage.routeName,
          arguments: message.data['videoId']);
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
}