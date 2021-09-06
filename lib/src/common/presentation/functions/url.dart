import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

Future<void> launchURL(BuildContext context, String url) async {
  final browser = ChromeSafariBrowser();

  await browser.open(
      url: Uri.parse(url),
      options: ChromeSafariBrowserClassOptions(
          android: AndroidChromeCustomTabsOptions(enableUrlBarHiding: true),
          ios: IOSSafariOptions(
              barCollapsingEnabled: true,
              preferredControlTintColor: Theme.of(context).accentColor)));
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

/*String _intToHex(int i) {
  final s = i.toRadixString(16);
  if (s.length == 8) {
    return '#' + s.substring(2).toUpperCase();
  } else {
    return '#' + s.toUpperCase();
  }
}*/
