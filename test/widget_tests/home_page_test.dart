import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/app.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/app_bar_title.dart';
import 'package:karate_stars_app/src/common/strings.dart';

import 'common/scenarios.dart';

void main() {
  group('home page', () {
    setUpAll(() {
      givenThereAreNoNews();
    });

    group('to open app ', () {
      testWidgets('should have correct title', (WidgetTester tester) async {
        await tester.pumpWidget(App());

        _expectTitle(tester, Strings.home_appbar_title_default);
      });

      testWidgets('should show filter button', (WidgetTester tester) async {
        await tester.pumpWidget(App());

        _expectIsVisible(Keys.home_filter, true);
      });
      testWidgets('should has news page view visible by default',
          (WidgetTester tester) async {
        await tester.pumpWidget(App());

        _expectVisibleTabContent(Keys.news_page_view);
      });
    });

    group('to navigate to competitors', () {
      testWidgets('should have correct title', (WidgetTester tester) async {
        await tester.pumpWidget(App());

        await _tapOnTab(tester, Keys.home_competitors_tab);

        _expectTitle(tester, Strings.home_appbar_title_competitors);
      });

      testWidgets('should not show filter button', (WidgetTester tester) async {
        await tester.pumpWidget(App());

        await _tapOnTab(tester, Keys.home_competitors_tab);

        _expectIsVisible(Keys.home_filter, false);
      });
      testWidgets('should has competitors page view visible',
          (WidgetTester tester) async {
        await tester.pumpWidget(App());

        await _tapOnTab(tester, Keys.home_competitors_tab);

        _expectVisibleTabContent(Keys.competitors_page_view);
      });
    });
  });

  group('to navigate to videos', () {
    testWidgets('should have correct title', (WidgetTester tester) async {
      await tester.pumpWidget(App());

      await _tapOnTab(tester, Keys.home_videos_tab);

      _expectTitle(tester, Strings.home_appbar_title_videos);
    });

    testWidgets('should not show filter button', (WidgetTester tester) async {
      await tester.pumpWidget(App());

      await _tapOnTab(tester, Keys.home_videos_tab);

      _expectIsVisible(Keys.home_filter, false);
    });

    testWidgets('should has videos page view visible',
        (WidgetTester tester) async {
      await tester.pumpWidget(App());

      await _tapOnTab(tester, Keys.home_videos_tab);

      _expectVisibleTabContent(Keys.videos_page_view);
    });
  });

  group('to navigate to settings', () {
    testWidgets('should have correct title', (WidgetTester tester) async {
      await tester.pumpWidget(App());

      await _tapOnTab(tester, Keys.home_settings_tab);

      _expectTitle(tester, Strings.home_appbar_title_settings);
    });

    testWidgets('should not show filter button', (WidgetTester tester) async {
      await tester.pumpWidget(App());

      await _tapOnTab(tester, Keys.home_settings_tab);

      _expectIsVisible(Keys.home_filter, false);
    });
    testWidgets('should has settings page view visible',
        (WidgetTester tester) async {
      await tester.pumpWidget(App());

      await _tapOnTab(tester, Keys.home_settings_tab);

      _expectVisibleTabContent(Keys.settings_page_view);
    });
  });
}

void _expectTitle(WidgetTester tester, String expectedTitle) {
  final titleFinder = find.descendant(
      of: find.byType(AppBarTitle), matching: find.byType(Text));

  final title = tester.widget<Text>(titleFinder).data;

  expect(title, expectedTitle);
}


Future<void> _tapOnTab(WidgetTester tester, String keyValue) async {
  await tester.tap(find.byKey(Key(keyValue)));
  await tester.pumpAndSettle();
}

void _expectVisibleTabContent(String tabKey) {
  _expectIsVisible(Keys.news_page_view, tabKey == Keys.news_page_view);
  _expectIsVisible(
      Keys.competitors_page_view, tabKey == Keys.competitors_page_view);
  _expectIsVisible(Keys.videos_page_view, tabKey == Keys.videos_page_view);
  _expectIsVisible(Keys.settings_page_view, tabKey == Keys.settings_page_view);
}

void _expectIsVisible(String keyValue, bool visible) {
  final titleFinder = find.byKey(Key(keyValue));

  if (visible) {
    expect(titleFinder, findsOneWidget);
  } else {
    expect(titleFinder, findsNothing);
  }
}
