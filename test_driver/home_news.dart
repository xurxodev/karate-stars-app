// Imports the Flutter Driver API

import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:test/test.dart';

import 'mocks/mothers/current_news_mother.dart';
import 'mocks/mothers/social_news_mother.dart';
import 'page_objects/home/home_page_object.dart';

void main() {
  group('home news', () {
    FlutterDriver driver;
    HomePageObject homePage;

    setUpAll(() async {
      driver = await FlutterDriver.connect();

      homePage = HomePageObject(driver);

      //Seems this sleep is necessary by driver bug with async main
      sleep(const Duration(milliseconds: 1000));
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('should show expected news title', () async {
      final newsList = getNews();

      for (var i = 0; i < newsList.length; i++) {
        final newsItem = newsList[i];

        // TODO(xurxodev): socialNews contains RichText and FlutterDriver has a
        //  bug getting text only for Text widgets is solved in v1.14.2
        //  https://github.com/flutter/flutter/issues/16013
        if (newsItem is CurrentNews) {
          await homePage.newsContent
              .assertNewsItemTitle(i, newsItem.summary.title);
        }
      }

      await homePage.newsContent.scrollToUp();
    });

    test('should show expected news source name', () async {
      final newsList = getNews();

      for (var i = 0; i < newsList.length; i++) {
        final newsItem = newsList[i];

        if (newsItem is CurrentNews) {
          await homePage.newsContent
              .assertNewsItemSource(i, newsItem.source.name);
        } else if (newsItem is SocialNews) {
          if (newsItem is CurrentNews) {
            await homePage.newsContent
                .assertNewsItemSource(i, newsItem.user.userName);
          }
        }
      }

      await homePage.newsContent.scrollToUp();
    });

    test('should show expected social badge for social news', () async {
      final newsList = getNews();

      for (var i = 0; i < newsList.length; i++) {
        final newsItem = newsList[i];

        if (newsItem is SocialNews) {
          await homePage.newsContent.assertSocialBadgeIsVisible(i);
        }
      }

      await homePage.newsContent.scrollToUp();
    });

    test('should not show social badge for current news', () async {
      final newsList = getNews();

      for (var i = 0; i < newsList.length; i++) {
        final newsItem = newsList[i];

        if (newsItem is CurrentNews) {
          await homePage.newsContent.assertSocialBadgeIsHidden(i);
        }
      }

      await homePage.newsContent.scrollToUp();
    });

    test('should show expected social user name for social news', () async {
      final newsList = getNews();

      for (var i = 0; i < newsList.length; i++) {
        final newsItem = newsList[i];

        if (newsItem is SocialNews) {
          await homePage.newsContent
              .assertNewsItemSocialUsername(i, '@${newsItem.user.userName}');
        }
      }

      await homePage.newsContent.scrollToUp();
    });

    test('should not show expected social user name for current news',
        () async {
      final newsList = getNews();

      for (var i = 0; i < newsList.length; i++) {
        final newsItem = newsList[i];

        if (newsItem is CurrentNews) {
          await homePage.newsContent.assertNewsItemSocialUsernameIsHidden(i);
        }
      }

      await homePage.newsContent.scrollToUp();
    });
  });
}

List<News> getNews() {
  final List<News> news = [];

  news.addAll(CurrentNewsMother.all());
  news.addAll(SocialNewsMother.all());

  news.sort((a, b) => b.summary.pubDate.date.compareTo(a.summary.pubDate.date));

  return news;
}
