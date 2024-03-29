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
const playVideoAdUnitId= 'playVideoAdUnitId';
const eventsAdUnitId = 'eventsAdUnitId';
const rankingsAdUnitId = 'rankingsAdUnitId';
const rankingCategoriesAdUnitId = 'rankingCategoriesAdUnitId';
const rankingEntriesAdUnitId = 'rankingEntriesAdUnitId';

const testingAndroidNativeAdId = 'ca-app-pub-3940256099942544/2247696110';
const testingIOSNativeAdId = 'ca-app-pub-3940256099942544/3986624511';
const testingAndroidInterstitialAdId = 'ca-app-pub-3940256099942544/8691691433';
const testingIOSInterstitialAdId = 'ca-app-pub-3940256099942544/5135589807';

const unitIds = {
  testingMode: {
    androidPlatform: {
      newsAdUnitId: testingAndroidNativeAdId,
      competitorsAdUnitId: testingAndroidNativeAdId,
      competitorAdUnitId: testingAndroidNativeAdId,
      videosAdUnitId: testingAndroidNativeAdId,
      videoAdUnitId: testingAndroidNativeAdId,
      searchNewsAdUnitId: testingAndroidNativeAdId,
      searchCompetitorsAdUnitId: testingAndroidNativeAdId,
      searchVideosAdUnitId: testingAndroidNativeAdId,
      playVideoAdUnitId:testingAndroidInterstitialAdId,
      eventsAdUnitId:testingAndroidNativeAdId,
      rankingsAdUnitId:testingAndroidNativeAdId,
      rankingCategoriesAdUnitId: testingAndroidNativeAdId,
      rankingEntriesAdUnitId:testingAndroidNativeAdId,
    },
    iosPlatform: {
      newsAdUnitId: testingIOSNativeAdId,
      competitorsAdUnitId: testingIOSNativeAdId,
      competitorAdUnitId: testingIOSNativeAdId,
      videosAdUnitId: testingIOSNativeAdId,
      videoAdUnitId: testingIOSNativeAdId,
      searchNewsAdUnitId: testingIOSNativeAdId,
      searchCompetitorsAdUnitId: testingIOSNativeAdId,
      searchVideosAdUnitId: testingIOSNativeAdId,
      playVideoAdUnitId:testingIOSInterstitialAdId,
      eventsAdUnitId:testingIOSNativeAdId,
      rankingsAdUnitId:testingIOSNativeAdId,
      rankingCategoriesAdUnitId: testingIOSNativeAdId,
      rankingEntriesAdUnitId:testingIOSNativeAdId,
    }
  },
  releaseMode: {
    androidPlatform: {
      newsAdUnitId: 'ca-app-pub-3409991930157804/9570454483',
      competitorsAdUnitId: 'ca-app-pub-3409991930157804/3667197593',
      competitorAdUnitId: 'ca-app-pub-3409991930157804/5627146523',
      videosAdUnitId: 'ca-app-pub-3409991930157804/8636646760',
      videoAdUnitId: 'ca-app-pub-3409991930157804/6322965308',
      searchNewsAdUnitId: 'ca-app-pub-3409991930157804/7741834667',
      searchCompetitorsAdUnitId: 'ca-app-pub-3409991930157804/1083081063',
      searchVideosAdUnitId: 'ca-app-pub-3409991930157804/7088719230',
      playVideoAdUnitId:'ca-app-pub-3409991930157804/6428822808',
      eventsAdUnitId:'ca-app-pub-3409991930157804/9973678813',
      rankingsAdUnitId:'ca-app-pub-3409991930157804/4488034958',
      rankingCategoriesAdUnitId: 'ca-app-pub-3409991930157804/6869869293',
      rankingEntriesAdUnitId:'ca-app-pub-3409991930157804/1253999970',
    },
    iosPlatform: {
      newsAdUnitId: 'ca-app-pub-3409991930157804/3193404938',
      competitorsAdUnitId: 'ca-app-pub-3409991930157804/6853448349',
      competitorAdUnitId: 'ca-app-pub-3409991930157804/9566391534',
      videosAdUnitId: 'ca-app-pub-3409991930157804/8636646760',
      videoAdUnitId: 'ca-app-pub-3409991930157804/9542340801',
      searchNewsAdUnitId: 'ca-app-pub-3409991930157804/8401800904',
      searchCompetitorsAdUnitId: 'ca-app-pub-3409991930157804/4185733035',
      searchVideosAdUnitId: 'ca-app-pub-3409991930157804/9709328934',
      playVideoAdUnitId:'ca-app-pub-3409991930157804/1176496126',
      eventsAdUnitId:'ca-app-pub-3409991930157804/8556655366',
      rankingsAdUnitId:'ca-app-pub-3409991930157804/1828715045',
      rankingCategoriesAdUnitId: 'ca-app-pub-3409991930157804/2493841714',
      rankingEntriesAdUnitId:'ca-app-pub-3409991930157804/5738920338',
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

  static String get playVideoInterstitialAdId {
    return unitIds[mode]![platform]![playVideoAdUnitId]!;
  }

  static String get eventsNativeAdUnitId {
    return unitIds[mode]![platform]![eventsAdUnitId]!;
  }

  static String get rankingsNativeAdUnitId {
    return unitIds[mode]![platform]![rankingsAdUnitId]!;
  }

  static String get rankingCategoriesNativeAdUnitId {
    return unitIds[mode]![platform]![rankingCategoriesAdUnitId]!;
  }

  static String get rankingEntriesNativeAdUnitId {
    return unitIds[mode]![platform]![rankingEntriesAdUnitId]!;
  }
}
