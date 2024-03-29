import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/common/presentation/boundaries/analytics.dart';
import 'package:karate_stars_app/src/rate_app/presentation/utils.dart';

Future<void> launchURL(BuildContext context, String url) async {

  final analyticsService = app_di.getIt<AnalyticsService>();

  analyticsService.sendScreenName('url:$url');

  final browser = ChromeSafariBrowser();

  await browser.open(
      url: Uri.parse(url),
      options: ChromeSafariBrowserClassOptions(
          android: AndroidChromeCustomTabsOptions(enableUrlBarHiding: true),
          ios: IOSSafariOptions(
              barCollapsingEnabled: true,
              preferredControlTintColor:
                  Theme.of(context).colorScheme.secondary)));

  increaseAppRateConversionCount();
}

String createTwitterURL(String text) {
  const baseAddress = 'https://twitter.com/';

  text = text.trim();

  if (text.substring(0, 1) == '#') {
    return baseAddress + 'hashtag/' + text.replaceFirst('#', '') + '?src=hash';
  } else if (text.substring(0, 1) == '@') {
    return baseAddress + text.replaceFirst('@', '');
  } else {
    return text;
  }
}

String createInstagramURL(String text) {
  const baseAddress = 'https://www.instagram.com/';

  text = text.trim();

  if (text.substring(0, 1) == '#') {
    return baseAddress + 'explore/tags/' + text.replaceFirst('#', '')  ;
  } else if (text.substring(0, 1) == '@') {
    return baseAddress + text.replaceFirst('@', '');
  } else {
    return text;
  }
}

String createFacebookURL(String text) {
  const baseAddress = 'https://www.facebook.com/';

  text = text.trim();

  if (text.substring(0, 1) == '#') {
    return baseAddress + 'hashtag/' + text.replaceFirst('#', '')  ;
  } else if (text.substring(0, 1) == '@') {
    return baseAddress + text.replaceFirst('@', '');
  } else {
    return text;
  }
}

/*String _intToHex(int i) {
  final s = i.toRadixString(16);
  if (s.length == 8) {
    return '#' + s.substring(2).toUpperCase();
  } else {
    return '#' + s.toUpperCase();
  }
}*/
