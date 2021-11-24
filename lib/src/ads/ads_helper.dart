import 'dart:io';

import 'package:flutter/foundation.dart';

const testingMode = 'testing';
const releaseMode = 'release';

const androidPlatform = 'android';
const iosPlatform = 'ios';

const newsAdUnitId = 'newsAdUnitId';
const competitorsAdUnitId = 'competitorsAdUnitId';
const competitorAdUnitId = 'competitorAdUnitId';
const videosAdUnitId = 'videosAdUnitId';
const videoAdUnitId = 'videoAdUnitId';
const searchNewsAdUnitId = 'searchNewsAdUnitId';
const searchCompetitorsAdUnitId = 'searchCompetitorsAdUnitId';
const searchVideosAdUnitId = 'searchVideosAdUnitId';

const testingNativeAdId = 'ca-app-pub-3940256099942544/2247696110';

const unitIds = {
  testingMode: {
    androidPlatform: {
      newsAdUnitId: testingNativeAdId,
      competitorsAdUnitId: testingNativeAdId,
      competitorAdUnitId: testingNativeAdId,
      videosAdUnitId: testingNativeAdId,
      videoAdUnitId: testingNativeAdId,
      searchNewsAdUnitId: testingNativeAdId,
      searchCompetitorsAdUnitId: testingNativeAdId,
      searchVideosAdUnitId: testingNativeAdId,
    },
    iosPlatform: {
      newsAdUnitId: testingNativeAdId,
      competitorsAdUnitId: testingNativeAdId,
      competitorAdUnitId: testingNativeAdId,
      videosAdUnitId: testingNativeAdId,
      videoAdUnitId: testingNativeAdId,
      searchNewsAdUnitId: testingNativeAdId,
      searchCompetitorsAdUnitId: testingNativeAdId,
      searchVideosAdUnitId: testingNativeAdId,
    }
  },
  releaseMode: {
    androidPlatform: {
      newsAdUnitId: 'ca-app-pub-3409991930157804/9570454483',
      competitorsAdUnitId: 'ca-app-pub-3409991930157804/3667197593',
      competitorAdUnitId: 'ca-app-pub-3409991930157804/5627146523',
      videosAdUnitId: 'ca-app-pub-3409991930157804/9542340801',
      videoAdUnitId: 'ca-app-pub-3409991930157804/6322965308',
      searchNewsAdUnitId: 'ca-app-pub-3409991930157804/7741834667',
      searchCompetitorsAdUnitId: 'ca-app-pub-3409991930157804/1083081063',
      searchVideosAdUnitId: 'ca-app-pub-3409991930157804/7088719230',
    },
    iosPlatform: {
      newsAdUnitId: 'ca-app-pub-3409991930157804/3193404938',
      competitorsAdUnitId: 'ca-app-pub-3409991930157804/6853448349',
      competitorAdUnitId: 'ca-app-pub-3409991930157804/9566391534',
      videosAdUnitId: 'ca-app-pub-3409991930157804/8636646760',
      videoAdUnitId: 'ca-app-pub-3409991930157804/8333200916',
      searchNewsAdUnitId: 'ca-app-pub-3409991930157804/8401800904',
      searchCompetitorsAdUnitId: 'ca-app-pub-3409991930157804/4185733035',
      searchVideosAdUnitId: 'ca-app-pub-3409991930157804/9709328934',
    }
  },
};

const mode = kReleaseMode ? releaseMode : testingMode;
final platform = Platform.isAndroid ? androidPlatform : iosPlatform;

mixin AdsHelper {
  static String get newsNativeAdUnitId {
    return unitIds[mode]![platform]![newsAdUnitId]!;
  }

  static String get competitorsNativeAdUnitId {
    return unitIds[mode]![platform]![competitorsAdUnitId]!;
  }

  static String get competitorNativeAdUnitId {
    return unitIds[mode]![platform]![competitorAdUnitId]!;
  }

  static String get videosNativeAdUnitId {
    return unitIds[mode]![platform]![videosAdUnitId]!;
  }

  static String get videoNativeAdUnitId {
    return unitIds[mode]![platform]![videoAdUnitId]!;
  }

  static String get searchNewsNativeAdUnitId {
    return unitIds[mode]![platform]![searchNewsAdUnitId]!;
  }

  static String get searchCompetitorsNativeAdUnitId {
    return unitIds[mode]![platform]![searchCompetitorsAdUnitId]!;
  }

  static String get searchVideosNativeAdUnitId {
    return unitIds[mode]![platform]![searchVideosAdUnitId]!;
  }
}
