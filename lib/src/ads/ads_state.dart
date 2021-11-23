import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsState {
  Future<InitializationStatus> initialization;

  AdsState(this.initialization);

  String get bannerAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  BannerAdListener adListener = BannerAdListener(onAdLoaded: (ad) => print('ad loaded: ${ad.adUnitId}'));
}
