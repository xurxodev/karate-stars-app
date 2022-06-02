import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';

import 'common/scenarios.dart';
import 'page_objects/home_page_object.dart';

void main() {
  group('home page news', () {
    group('should show notification message', () {
      testWidgets('of empty data if has no data', (WidgetTester tester) async {
        await givenThereAreNoData();

        final home = HomePageObject(tester);
        await home.open();

        home.news.expectNotificationMessage(Strings.news_empty_message);
      });

      testWidgets('of network error if an network error occur',
          (WidgetTester tester) async {
        await givenThereAreOnlyNewsAndThrowNetworkException();
        final home = HomePageObject(tester);
        await home.open();

        home.news.expectNotificationMessage(Strings.network_error_message);
      });
    });
    group('with news', () {
      late HomePageObject home;

      final givenThereAreNewsAndInitHome = (tester) async {
        final newsList = await givenThereAreOnlyNews();
        home = HomePageObject(tester);
        await home.open();

        return newsList;
      };

      testWidgets('should show expected title in news items',
          (WidgetTester tester) async {
        final newsList = await givenThereAreNewsAndInitHome(tester);

        for (News newsItem in newsList) {
          await home.news.expectItemTitle(
              newsList.indexOf(newsItem), newsItem.summary.title);
        }
      });

      testWidgets('should show expected news source name',
          (WidgetTester tester) async {
        final newsList = await givenThereAreNewsAndInitHome(tester);

        await Future.forEach(newsList, (newsItem) async {
          if (newsItem is CurrentNews) {
            await home.news.expectItemSource(
                newsList.indexOf(newsItem), newsItem.source.name);
          } else if (newsItem is SocialNews) {
            await home.news.expectItemSource(
                newsList.indexOf(newsItem), newsItem.user.name);
          }
        });
      });

      testWidgets('should show social badge only for social news',
          (WidgetTester tester) async {
        final newsList = await givenThereAreNewsAndInitHome(tester);

        await Future.forEach(newsList, (newsItem) async {
          if (newsItem is SocialNews) {
            await home.news.expectSocialBadgeIsVisible(
                newsList.indexOf(newsItem), true);
          }
        });
      });

      testWidgets('should show expected social user name for social news',
          (WidgetTester tester) async {
        final newsList = await givenThereAreNewsAndInitHome(tester);

        await Future.forEach(newsList, (newsItem) async {
          if (newsItem is SocialNews) {
            await home.news.expectedNewsItemSocialUsername(
                newsList.indexOf(newsItem), '@${newsItem.user.userName}');
          }
        });
      });

      testWidgets('should not show expected social user name for current news',
          (WidgetTester tester) async {
        final newsList = await givenThereAreNewsAndInitHome(tester);

        await Future.forEach(newsList, (newsItem) async {
          if (newsItem is CurrentNews) {
            await home.news.expectSocialUsernameIsVisible(
                newsList.indexOf(newsItem), false);
          }
        });
      });
    });
  });
}
