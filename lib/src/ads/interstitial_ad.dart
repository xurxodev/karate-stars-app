import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:karate_stars_app/src/ads/ads_helper.dart';
import 'package:karate_stars_app/src/app/app_bloc.dart';
import 'package:karate_stars_app/src/app/app_state.dart' as my_app;
import 'package:karate_stars_app/src/app/app_state.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';

class PlayVideoInterstitialAd {
  InterstitialAd? _interstitialAd;
  late StreamSubscription<my_app.AppState> _appStateSubscription;

  PlayVideoInterstitialAd(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);

    loadByPremium(appBloc.state);

    _appStateSubscription = appBloc.observableState.listen((state) {
        loadByPremium(state);
    });
  }

  void loadByPremium(DefaultState<my_app.AppStateData> state) {
    if (state is LoadedState<AppStateData>) {
      final isPremium = state.data.isPremium;

      if (!isPremium) {
        _loadAd();
      } else {
        _interstitialAd = null;
      }
    }
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
    _appStateSubscription.cancel();
    _interstitialAd?.dispose();
  }
}
