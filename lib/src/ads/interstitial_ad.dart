import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:karate_stars_app/src/ads/ads_helper.dart';

class PlayVideoInterstitialAd {
  InterstitialAd? _interstitialAd;

  PlayVideoInterstitialAd() {
    _loadAd();
  }

  void _loadAd() {
    InterstitialAd.load(
      adUnitId: AdsHelper.playVideoInterstitialAdId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError err) {
          print('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  void show() {
    if (_interstitialAd != null) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          ad.dispose();
          _loadAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          ad.dispose();
        },
      );
      _interstitialAd!.show();
      _loadAd();
    }
  }

  void dispose() {
    _interstitialAd?.dispose();
  }
}
