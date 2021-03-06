import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';

import 'common/scenarios.dart';
import 'page_objects/home_page_object.dart';

void main() {
  group('home page news', () {
    group('should show notification message', () {
      testWidgets('of empty data if has no data', (WidgetTester tester) async {
        givenThereAreNoNews();
        final home = HomePageObject(tester);
        await home.open();

        home.news.expectNotificationMessage(Strings.news_empty_message);
      });

      testWidgets('of network error if an network error occur',
          (WidgetTester tester) async {
        givenThatNewsDataThrowNetworkException();
        final home = HomePageObject(tester);
        await home.open();

        home.news.expectNotificationMessage(Strings.network_error_message);
      });
    });
    group('with news', () {
      HomePageObject home;

      final givenThereAreNewsAndInitHome = (tester) async {
        final newsList = givenThereAreNews();
        home = HomePageObject(tester);
        await home.open();

        return newsList;
      };

      testWidgets('should show expected title in news items',
          (WidgetTester tester) async {
        final newsList = await givenThereAreNewsAndInitHome(tester);

        await Future.forEach(newsList, (newsItem) async {
          await home.news.expectItemTitle(
              newsList.indexOf(newsItem), newsItem.summary.title);
        });
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
          await home.news.expectSocialBadgeIsVisible(
              newsList.indexOf(newsItem), newsItem is SocialNews);
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

      testWidgets('should filter by current news', (WidgetTester tester) async {
        final newsList = await givenThereAreNewsAndInitHome(tester);

        await home.news.filterByCurrentNews();
        final currentNewsList = newsList.whereType<CurrentNews>().toList();

        await Future.forEach(currentNewsList, (newsItem) async {
          if (newsItem is CurrentNews) {
            await home.news.expectSocialBadgeIsVisible(
                currentNewsList.indexOf(newsItem), false);
          }
        });
      });

      testWidgets('should filter by social news', (WidgetTester tester) async {
        final newsList = await givenThereAreNewsAndInitHome(tester);

        await home.news.filterBySocialNews();
        final socialNewsList = newsList.whereType<SocialNews>().toList();

        await Future.forEach(socialNewsList, (newsItem) async {
          if (newsItem is SocialNews) {
            await home.news.expectSocialBadgeIsVisible(
                socialNewsList.indexOf(newsItem), true);
          }
        });
      });
    });
  });
}
