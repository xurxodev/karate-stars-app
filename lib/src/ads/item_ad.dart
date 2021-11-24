import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/RoundedCard.dart';

class ItemAd extends StatelessWidget {
  final NativeAd nativeAd;
  final EdgeInsetsGeometry? margin;

  const ItemAd({required this.nativeAd, this.margin});

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(20.0);

    return RoundedCard(
        color: const Color(0xFFFAFAFA),
        elevation: 0.0,
        margin: margin,
        borderRadius: const BorderRadius.all(radius),
        child: Container(
          height: 75,
          padding: const EdgeInsets.all(8),
          child: AdWidget(ad: nativeAd),
          alignment: Alignment.center,
        ));
  }
}
