import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index);

class AdsListView extends StatefulWidget {
  final String adUnitId;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Widget Function(BuildContext context, NativeAd ad) adBuilder;
  final EdgeInsetsGeometry? padding;

  const AdsListView(
      {required this.adUnitId,
      required this.itemCount,
      required this.itemBuilder,
      required this.adBuilder,
      this.padding});

  @override
  _AdsListViewState createState() => _AdsListViewState();
}

class _AdsListViewState extends State<AdsListView> {
  static const _defaultAdIndex = 4;
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
    return ListView.builder(
        padding: widget.padding,
        itemCount: widget.itemCount + (_isAdLoaded ? 1 : 0),
        itemBuilder: (context, index) {
          if (_isAdLoaded && index == _adIndex) {
            return widget.adBuilder(context, _ad);
          } else {
            return widget.itemBuilder(context, _getOriginalItemIndex(index));
          }
        });
  }

  int get _adIndex {
    return widget.itemCount > _defaultAdIndex - 1
        ? _defaultAdIndex
        : widget.itemCount;
  }

  int _getOriginalItemIndex(int rawIndex) {
    if (rawIndex >= _adIndex && _isAdLoaded) {
      return rawIndex - 1;
    }
    return rawIndex;
  }

  @override
  void dispose() {
    super.dispose();
    _ad.dispose();
  }
}
