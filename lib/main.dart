import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //HttpOverrides.global = MyHttpOverrides();

  //default filename is .env
  //if (kReleaseMode) {
    await dotenv.load(
        fileName: '.env.production', mergeWith: Platform.environment);
  // } else {
  //  await dotenv.load(
  //      fileName: '.env.development', mergeWith: Platform.environment);
  // }

  await Firebase.initializeApp();

  MobileAds.instance.initialize();

  await app_di.init();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(App.create(testing: false));
}

/*// To avoid in Android the error with https images
  // Only old devices
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}*/
