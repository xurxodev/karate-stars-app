import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/home/presentation/widgets/home_page_view.dart';
import 'package:karate_stars_app/src/news/presentation/page/current_news_page.dart';

class HomeNewsPageObject {
  final WidgetTester _tester;

  HomeNewsPageObject(this._tester);

  void expectNotificationMessage(String message) {
    final notificationMessageFinder = find.descendant(
        of: find.byType(HomePageView), matching: find.text(message));

    expect(notificationMessageFinder, findsOneWidget);
  }

  Future<void> expectItemTitle(int index, String expectedTitle) async {
    await _scrollUntilVisible(index);

    final widget =
        _tester.widget(_findItemChildByKey(index, Keys.news_item_title));

    String? text = '';

    if (widget is Text) {
      text = widget.data;
    } else if (widget is ParsedText) {
      text = widget.text;
    }

    expect(text, expectedTitle);
  }

  Future<void> expectItemSource(int index, String expectedSource) async {
    await _scrollUntilVisible(index);

    final sourceText = _tester
        .widget<Text>(_findItemChildByKey(index, Keys.news_item_source))
        .data;

    expect(sourceText, expectedSource);
  }

  Future<void> expectSocialBadgeIsVisible(int index, bool visible) async {
    await _scrollUntilVisible(index);

    final itemSourceFinder =
        _findItemChildByKey(index, Keys.news_item_social_badge);

    if (visible) {
      expect(itemSourceFinder, findsOneWidget);
    } else {
      expect(itemSourceFinder, findsNothing);
    }
  }

  Future<void> expectedNewsItemSocialUsername(
      int index, String expectedUsername) async {
    await _scrollUntilVisible(index);

    final usernameText = _tester
        .widget<Text>(
            _findItemChildByKey(index, Keys.news_item_social_username))
        .data;

    expect(usernameText, expectedUsername);
  }

  Future<void> expectSocialUsernameIsVisible(int index, bool visible) async {
    await _scrollUntilVisible(index);

    final itemUsernameFinder =
        _findItemChildByKey(index, Keys.news_item_social_username);

    if (visible) {
      expect(itemUsernameFinder, findsOneWidget);
    } else {
      expect(itemUsernameFinder, findsNothing);
    }
  }

  Future<void> filterByCurrentNews() async {
    await _openFilterDialogByKey(Keys.news_filter_action);

    await _tester.tap(find.text(Strings.news_filters_current));

    await _closeFilterDialog();
  }

  Future<void> filterBySocialNews() async {
    await _openFilterDialogByKey(Keys.news_filter_action);

    await _tester.tap(find.text(Strings.news_filters_social));

    await _closeFilterDialog();
  }

  Future<void> filterByAllNews() async {
    await _openFilterDialogByKey(Keys.news_filter_action);

    await _tester.tap(find.text(Strings.default_filters_all));

    await _closeFilterDialog();
  }

  Future<void> _openFilterDialogByKey(String key) async {
    await _tester.tap(find.byKey(Key(key)));
    await _tester.pumpAndSettle();
  }

  Future<void> _closeFilterDialog() async {
    await _tester.tap(find.byKey(const Key(Keys.alert_dialog_ok_button)));
    await _tester.pumpAndSettle();
  }

  Future<void> _scrollUntilVisible(int index) async {
    final itemFinder = find.byKey(Key(_itemKeyValue(index)));

    await _tester.ensureVisible(itemFinder);
    await _tester.pump();
  }

  Finder _findItemChildByKey(int index, String suffix) {
    final itemUsernameKey = '${_itemKeyValue(index)}_$suffix';
    return find.byKey(Key(itemUsernameKey));
  }

  String _itemKeyValue(int index) {
    return '${Keys.news_item}_$index';
  }
}
