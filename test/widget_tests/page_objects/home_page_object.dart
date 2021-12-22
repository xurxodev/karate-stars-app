import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/app.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'home_news_page_object.dart';

class HomePageObject {
  final WidgetTester _tester;
  final HomeNewsPageObject news;

  HomePageObject(this._tester) : news = HomeNewsPageObject(_tester);

  Future open() async {
    await _tester.pumpWidget(App.create(testing: true));
    await _tester.pumpAndSettle();
  }

  void expectTitle(String expectedTitle) {
    final titleFinder =
        find.descendant(of: find.byType(AppBar), matching: find.byType(Text));

    final title = _tester.widget<Text>(titleFinder).data;

    expect(title, expectedTitle);
  }

  Future<void> tapOnTab(String keyValue) async {
    await _tester.tap(find.byKey(Key(keyValue)));
    await _tester.pumpAndSettle();
  }

  void expectVisibleTabContent(String tabKey) {
    expectIsVisible(Keys.news_page_view, tabKey == Keys.news_page_view);
    expectIsVisible(
        Keys.competitors_page_view, tabKey == Keys.competitors_page_view);
    expectIsVisible(Keys.videos_page_view, tabKey == Keys.videos_page_view);
    expectIsVisible(Keys.search_page_view, tabKey == Keys.search_page_view);
  }

  void expectIsVisible(String keyValue, bool visible) {
    final titleFinder = find.byKey(Key(keyValue));

    if (visible) {
      expect(titleFinder, findsOneWidget);
    } else {
      expect(titleFinder, findsNothing);
    }
  }
}
