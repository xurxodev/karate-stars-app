import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/ads/ads_state.dart';
import 'package:karate_stars_app/src/app.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //default filename is .env
  await dotenv.load();

  await Firebase.initializeApp();

  final initFuture = MobileAds.instance.initialize();
  final adState = AdsState(initFuture);

  await app_di.init();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(Provider.value(
      value: adState, builder: (context, child) => App.create(testing: false)));
}
