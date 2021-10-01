import 'package:flutter_driver/flutter_driver.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:test/test.dart';

class NewsContent {
  final FlutterDriver _driver;

  NewsContent(this._driver);

  final newsPageViewFinder = find.byValueKey(Keys.news_page_view);
  final notificationFinder = find.byValueKey(Keys.notification_message);
  final listFinder = find.byValueKey(Keys.news_items_parent);
  final alertDialogFinder = find.byValueKey(Keys.alert_dialog);

  Future<void> assertIsVisible() => _driver.waitFor(newsPageViewFinder);

  Future<void> assertNotificationMessage(String expectedMessage) async =>
      await _driver.runUnsynchronized(() async {
        expect(await _driver.getText(notificationFinder), expectedMessage);
      });

  Future<void> assertNewsItemTitle(int index, String expectedTitle) async {
    final itemTextKey = '${Keys.news_item}_$index';
    final itemTitleKey = '${itemTextKey}_${Keys.news_item_title}';

    final itemFinder = find.byValueKey(itemTextKey);
    final itemTitleFinder = find.byValueKey(itemTitleKey);

    await _scrollUntilItem(itemFinder);

    expect(await _driver.getText(itemTitleFinder), expectedTitle);
  }

  Future<void> assertNewsItemSource(int index, String expectedSource) async {
    final itemTextKey = '${Keys.news_item}_$index';
    final itemSourceKey = '${itemTextKey}_${Keys.news_item_source}';

    final itemFinder = find.byValueKey(itemTextKey);
    final itemSourceFinder = find.byValueKey(itemSourceKey);

    await _scrollUntilItem(itemFinder);

    expect(await _driver.getText(itemSourceFinder), expectedSource);
  }

  Future<void> assertSocialBadgeIsVisible(int index) async {
    final itemTextKey = '${Keys.news_item}_$index';
    final itemSocialBadge = '${itemTextKey}_${Keys.news_item_social_badge}';

    final itemFinder = find.byValueKey(itemTextKey);
    final itemSocialBadgeFinder = find.byValueKey(itemSocialBadge);

    await _scrollUntilItem(itemFinder);

    await _driver.waitFor(itemSocialBadgeFinder);
  }

  Future<void> assertSocialBadgeIsHidden(int index) async {
    final itemTextKey = '${Keys.news_item}_$index';
    final itemSocialBadge = '${itemTextKey}_${Keys.news_item_social_badge}';

    final itemFinder = find.byValueKey(itemTextKey);
    final itemSocialBadgeFinder = find.byValueKey(itemSocialBadge);

    await _scrollUntilItem(itemFinder);

    await _driver.waitForAbsent(itemSocialBadgeFinder);
  }

  Future<void> assertNewsItemSocialUsername(
      int index, String expectedUsername) async {
    final itemTextKey = '${Keys.news_item}_$index';
    final itemSocialUsernameKey =
        '${itemTextKey}_${Keys.news_item_social_username}';

    final itemFinder = find.byValueKey(itemTextKey);
    final itemSocialUsernameFinder = find.byValueKey(itemSocialUsernameKey);

    await _scrollUntilItem(itemFinder);

    expect(await _driver.getText(itemSocialUsernameFinder), expectedUsername);
  }

  Future<void> assertNewsItemSocialUsernameIsHidden(int index) async {
    final itemTextKey = '${Keys.news_item}_$index';
    final itemSocialUsernameKey =
        '${itemTextKey}_${Keys.news_item_social_username}';

    final itemFinder = find.byValueKey(itemTextKey);
    final itemSocialUsernameFinder = find.byValueKey(itemSocialUsernameKey);

    await _scrollUntilItem(itemFinder);

    await _driver.waitForAbsent(itemSocialUsernameFinder);
  }

  Future<void> scrollToUp() async {
    await _driver.scroll(
        listFinder, 0, 3000, const Duration(milliseconds: 500));
  }

  Future<void> filterByCurrentNews() async {
    await _openFilterDialog();

    final currentFilterFinder = find.text(Strings.news_filters_current);

    await _driver.waitFor(currentFilterFinder);
    await _driver.tap(currentFilterFinder);

    await _closeFilterDialog();
  }

  Future<void> filterBySocialNews() async {
    await _openFilterDialog();

    final socialFilterFinder = find.text(Strings.news_filters_social);

    await _driver.waitFor(socialFilterFinder);
    await _driver.tap(socialFilterFinder);

    await _closeFilterDialog();
  }

  Future<void> filterByAllNews() async {
    await _openFilterDialog();

    final allFilterFinder = find.text(Strings.default_filters_all);

    await _driver.waitFor(allFilterFinder);
    await _driver.tap(allFilterFinder);

    await _closeFilterDialog();
  }

  Future<void> _openFilterDialog() async {
    final filterButtonFinder = find.byValueKey(Keys.news_filter_action);

    await _driver.tap(filterButtonFinder);
    await _driver.waitFor(alertDialogFinder);
  }

  Future<void> _closeFilterDialog() async {
    final okButtonFinder = find.byValueKey(Keys.alert_dialog_ok_button);

    await _driver.tap(okButtonFinder);
    await _driver.waitUntilNoTransientCallbacks();
  }

  Future<void> _scrollUntilItem(SerializableFinder itemFinder) async {
    await _driver.waitFor(listFinder);
    await _driver.scrollUntilVisible(listFinder, itemFinder, dyScroll: -100);
  }
}
