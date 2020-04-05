import 'package:flutter/widgets.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/news_page_view.dart';

class HomeNewsPageObject {
  final WidgetTester _tester;

  HomeNewsPageObject(this._tester);

  void expectNotificationMessage(String message) {
    final notificationMessageFinder = find.descendant(
        of: find.byType(NewsPageView), matching: find.text(message));

    expect(notificationMessageFinder, findsOneWidget);
  }

  Future<void> expectItemTitle(int index, String expectedTitle) async {
    await _scrollUntilVisible(index);

    final itemTitleKey = '${_itemKeyValue(index)}_${Keys.news_item_title}';
    final itemTitleFinder = find.byKey(Key(itemTitleKey));

    final widget = _tester.widget(itemTitleFinder);

    String text = '';

    if (widget is Text) {
      text = widget.data;
    } else if (widget is ParsedText) {
      text = widget.text;
    }

    expect(text, expectedTitle);
  }

  Future<void> expectItemSource(int index, String expectedSource) async {
    await _scrollUntilVisible(index);

    final itemSourceKey = '${_itemKeyValue(index)}_${Keys.news_item_source}';
    final itemSourceFinder = find.byKey(Key(itemSourceKey));

    final sourceText = _tester.widget<Text>(itemSourceFinder).data;

    expect(sourceText, expectedSource);
  }

  Future<void> expectSocialBadgeIsVisible(int index, bool visible) async {
    await _scrollUntilVisible(index);

    final itemSourceKey =
        '${_itemKeyValue(index)}_${Keys.news_item_social_badge}';
    final itemSourceFinder = find.byKey(Key(itemSourceKey));

    if (visible) {
      expect(itemSourceFinder, findsOneWidget);
    } else {
      expect(itemSourceFinder, findsNothing);
    }
  }

  Future<void> expectedNewsItemSocialUsername(int index, String expectedUsername) async {
    await _scrollUntilVisible(index);

    final itemUsernameKey =
        '${_itemKeyValue(index)}_${Keys.news_item_social_username}';
    final itemUsernameFinder = find.byKey(Key(itemUsernameKey));

    final usernameText = _tester.widget<Text>(itemUsernameFinder).data;

    expect(usernameText, expectedUsername);
  }

  Future<void> expectSocialUsernameIsVisible(int index, bool visible) async {
    await _scrollUntilVisible(index);

    final itemSourceKey =
        '${_itemKeyValue(index)}_${Keys.news_item_social_username}';
    final itemSourceFinder = find.byKey(Key(itemSourceKey));

    if (visible) {
      expect(itemSourceFinder, findsOneWidget);
    } else {
      expect(itemSourceFinder, findsNothing);
    }
  }

  Future<void> filterByCurrentNews() async {
    await _openFilterDialog();

    await _tester.tap(find.text(Strings.news_filters_current));

    await _closeFilterDialog();
  }

  Future<void> filterBySocialNews() async {
    await _openFilterDialog();

    await _tester.tap(find.text(Strings.news_filters_social));

    await _closeFilterDialog();
  }

  Future<void> filterByAllNews() async {
    await _openFilterDialog();

    await _tester.tap(find.text(Strings.news_filters_all));

    await _closeFilterDialog();
  }

  Future<void> _openFilterDialog() async {
    await _tester.tap(find.byKey(Key(Keys.home_filter)));
    await _tester.pumpAndSettle();
  }

  Future<void> _closeFilterDialog() async {
    await _tester.tap(find.byKey(Key(Keys.alert_dialog_ok_button)));
    await _tester.pumpAndSettle();
  }

  Future<void> _scrollUntilVisible(int index) async {
    final itemFinder = find.byKey(Key(_itemKeyValue(index)));

    await _tester.ensureVisible(itemFinder);
    await _tester.pump();
  }

  String _itemKeyValue(int index) {
    return '${Keys.news_item}_$index';
  }
}
