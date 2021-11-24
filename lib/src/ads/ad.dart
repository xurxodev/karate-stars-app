import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index);

class Ad extends StatefulWidget {
  final String adUnitId;

  const Ad({required this.adUnitId});

  @override
  _AdState createState() => _AdState();
}

class _AdState extends State<Ad> {
  late NativeAd _ad;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();

    _ad = NativeAd(
      adUnitId: widget.adUnitId,
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();

          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );

    _ad.load();
  }

  @override
  Widget build(BuildContext context) {
    return _isAdLoaded? Container(
          height: 75,
          padding: const EdgeInsets.all(8),
          child: AdWidget(ad: _ad),
          alignment: Alignment.center,
        ): Container();
  }

  @override
  void dispose() {
    super.dispose();
    _ad.dispose();
  }
}
