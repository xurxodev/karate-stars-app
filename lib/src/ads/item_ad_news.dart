import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_news.dart';

class ItemAdNews extends ItemNews {
  final NativeAd nativeAd;

  const ItemAdNews({required this.nativeAd})
      : super(color: const Color(0xFFFAFAFA) );

  @override
  Widget buildContent(BuildContext context) {
    return Container(
      height: 75,
      padding: const EdgeInsets.all(8),
      child: AdWidget(ad: nativeAd),
      alignment: Alignment.center,
    );
  }
}
