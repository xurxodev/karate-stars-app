import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/strings.dart';

import 'common/scenarios.dart';
import 'page_objects/home_page_object.dart';

void main() {
  group('home page', () {
    setUpAll(() async {
      await givenThereAreNoData();
    });

    group('to open app ', () {
      testWidgets('should have correct title', (WidgetTester tester) async {
        final home = HomePageObject(tester);
        await home.open();

        home.expectTitle(Strings.home_appbar_title_default);
      });

      testWidgets('should show filter button', (WidgetTester tester) async {
        final home = HomePageObject(tester);
        await home.open();

        expect(find.byIcon(Icons.filter_list), findsOneWidget);
      });
      testWidgets('should has news page view visible by default',
          (WidgetTester tester) async {
        final home = HomePageObject(tester);
        await home.open();

        home.expectVisibleTabContent(Keys.news_page_view);
      });
    });

    group('to navigate to search', () {
      testWidgets('should have correct title', (WidgetTester tester) async {
        final home = HomePageObject(tester);
        await home.open();

        await home.tapOnTab(Keys.home_search_tab);

        home.expectTitle(Strings.home_appbar_title_settings);
      });

      testWidgets('should not show filter button', (WidgetTester tester) async {
        final home = HomePageObject(tester);
        await home.open();

        await home.tapOnTab(Keys.home_search_tab);

        expect(find.byIcon(Icons.filter_list), findsNothing);
      });
      testWidgets('should has search page view visible',
              (WidgetTester tester) async {
            final home = HomePageObject(tester);
            await home.open();

            await home.tapOnTab(Keys.home_search_tab);

            home.expectVisibleTabContent(Keys.search_page_view);
          });
    });

    group('to navigate to competitors', () {
      testWidgets('should have correct title', (WidgetTester tester) async {
        final home = HomePageObject(tester);
        await home.open();

        await home.tapOnTab(Keys.home_competitors_tab);

        home.expectTitle(Strings.home_appbar_title_competitors);
      });

      testWidgets('should show filter button', (WidgetTester tester) async {
        final home = HomePageObject(tester);
        await home.open();

        await home.tapOnTab(Keys.home_competitors_tab);

        expect(find.byIcon(Icons.filter_list), findsOneWidget);
      });
      testWidgets('should has competitors page view visible',
          (WidgetTester tester) async {
        final home = HomePageObject(tester);
        await home.open();

        await home.tapOnTab(Keys.home_competitors_tab);

        home.expectVisibleTabContent(Keys.competitors_page_view);
      });
    });
  });

  group('to navigate to videos', () {
    testWidgets('should have correct title', (WidgetTester tester) async {
      final home = HomePageObject(tester);
      await home.open();

      await home.tapOnTab(Keys.home_videos_tab);

      home.expectTitle(Strings.home_appbar_title_videos);
    });

    testWidgets('should show filter button', (WidgetTester tester) async {
      final home = HomePageObject(tester);
      await home.open();

      await home.tapOnTab(Keys.home_videos_tab);

      expect(find.byIcon(Icons.filter_list), findsOneWidget);
    });

    testWidgets('should has videos page view visible',
        (WidgetTester tester) async {
      final home = HomePageObject(tester);
      await home.open();

      await home.tapOnTab(Keys.home_videos_tab);

      home.expectVisibleTabContent(Keys.videos_page_view);
    });
  });


}
