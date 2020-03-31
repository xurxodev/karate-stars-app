import 'package:flutter/widgets.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/app.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/news_page_view.dart';

import '../common/mothers/current_news_mother.dart';
import '../common/mothers/social_news_mother.dart';
import 'common/scenarios.dart';

void main() {
  group('home page news', () {
    group('should show notification message', () {
      testWidgets('of empty data if has no data', (WidgetTester tester) async {
        givenThereAreNoNews();
        await tester.pumpWidget(App());
        await tester.pumpAndSettle();

        _expectNotificationMessage(tester, Strings.news_empty_message);
      });

      testWidgets('of network error if an network error occur',
          (WidgetTester tester) async {
        givenThatNewsDataThrowNetworkException();
        await tester.pumpWidget(App());
        await tester.pumpAndSettle();

        _expectNotificationMessage(tester, Strings.network_error_message);
      });
    });
    group('with news', () {
      testWidgets('should show expected title in news items',
          (WidgetTester tester) async {
        givenThereAreNews();
        await tester.pumpWidget(App());
        await tester.pumpAndSettle();

        final newsList = _getNews();

        for (var i = 0; i < newsList.length; i++) {
          final newsItem = newsList[i];

          await expectNewsItemTitle(tester, i, newsItem.summary.title);
        }
      });
    });
  });
}

void _expectNotificationMessage(WidgetTester tester, String message) {
  final notificationMessageFinder = find.descendant(
      of: find.byType(NewsPageView), matching: find.text(message));

  expect(notificationMessageFinder, findsOneWidget);
}

Future<void> expectNewsItemTitle(
    WidgetTester tester, int index, String expectedTitle) async {
  await _scrollUntilVisible(tester, index);

  final itemTitleKey = '${_itemKeyValue(index)}_${Keys.news_item_title}';
  final itemTitleFinder = find.byKey(Key(itemTitleKey));

  final widget = tester.widget(itemTitleFinder);

  String text = '';

  if (widget is Text) {
    text = widget.data;
  } else if (widget is ParsedText) {
    text = widget.text;
  }

  expect(text, expectedTitle);
}

Future<void> _scrollUntilVisible(WidgetTester tester, int index) async {
  final itemFinder = find.byKey(Key(_itemKeyValue(index)));

  await tester.ensureVisible(itemFinder);
  await tester.pump();
}

String _itemKeyValue(int index) {
  return '${Keys.news_item}_$index';
}

List<News> _getNews() {
  final List<News> news = [];

  news.addAll(CurrentNewsMother.all());
  news.addAll(SocialNewsMother.all());

  news.sort((a, b) => b.summary.pubDate.date.compareTo(a.summary.pubDate.date));

  return news;
}
