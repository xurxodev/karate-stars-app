import 'package:test/test.dart';
import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';

void main() {
  group('PubDate should', () {
    test('throw assertion error if date is null', () {
      expect(() => PubDate(null), throwsA(isA<AssertionError>()));
    });

    test('return antiquity 1d if pub date ago is 24 hours', () {
      final int oneDayMillis = DateTime.now().millisecondsSinceEpoch -
          const Duration(hours: 24).inMilliseconds;

      final pubDate =
          PubDate(DateTime.fromMillisecondsSinceEpoch(oneDayMillis));

      expect(pubDate.antiquity, '1d');
    });

    test('return antiquity 1d if pub date ago is between 1 and 2 days', () {
      final int oneDayMillis = DateTime.now().millisecondsSinceEpoch -
          const Duration(hours: 34).inMilliseconds;

      final pubDate =
      PubDate(DateTime.fromMillisecondsSinceEpoch(oneDayMillis));

      expect(pubDate.antiquity, '1d');
    });

    test('return antiquity in days if pub date ago is greater than 1 day', () {
      final int oneDayMillis = DateTime.now().millisecondsSinceEpoch -
          const Duration(days: 4).inMilliseconds;

      final pubDate =
      PubDate(DateTime.fromMillisecondsSinceEpoch(oneDayMillis));

      expect(pubDate.antiquity, '4d');
    });

    test('return antiquity 1h if pub date ago is 60 minutes', () {
      final int oneDayMillis = DateTime.now().millisecondsSinceEpoch -
          const Duration(minutes: 60).inMilliseconds;

      final pubDate =
      PubDate(DateTime.fromMillisecondsSinceEpoch(oneDayMillis));

      expect(pubDate.antiquity, '1h');
    });

    test('return antiquity 1h if pub date ago is between 1 and 2 hours', () {
      final int oneDayMillis = DateTime.now().millisecondsSinceEpoch -
          const Duration(minutes: 83).inMilliseconds;

      final pubDate =
      PubDate(DateTime.fromMillisecondsSinceEpoch(oneDayMillis));

      expect(pubDate.antiquity, '1h');
    });

    test('return antiquity in hours if pub date ago is greater than 1 hour', () {
      final int oneDayMillis = DateTime.now().millisecondsSinceEpoch -
          const Duration(hours: 23).inMilliseconds;

      final pubDate =
      PubDate(DateTime.fromMillisecondsSinceEpoch(oneDayMillis));

      expect(pubDate.antiquity, '23h');
    });

    test('return antiquity 1m if pub date ago is 60 minutes', () {
      final int oneDayMillis = DateTime.now().millisecondsSinceEpoch -
          const Duration(seconds: 60).inMilliseconds;

      final pubDate =
      PubDate(DateTime.fromMillisecondsSinceEpoch(oneDayMillis));

      expect(pubDate.antiquity, '1m');
    });

    test('return antiquity 1m if pub date ago is between 1 and 2 minutes', () {
      final int oneDayMillis = DateTime.now().millisecondsSinceEpoch -
          const Duration(seconds: 83).inMilliseconds;

      final pubDate =
      PubDate(DateTime.fromMillisecondsSinceEpoch(oneDayMillis));

      expect(pubDate.antiquity, '1m');
    });

    test('return antiquity in minutes if pub date ago is greater than 1 minute', () {
      final int oneDayMillis = DateTime.now().millisecondsSinceEpoch -
          const Duration(minutes: 23).inMilliseconds;

      final pubDate =
      PubDate(DateTime.fromMillisecondsSinceEpoch(oneDayMillis));

      expect(pubDate.antiquity, '23m');
    });

    test('return antiquity 1s if pub date ago is 1000 miliseconds', () {
      final int oneDayMillis = DateTime.now().millisecondsSinceEpoch -
          const Duration(milliseconds: 1000).inMilliseconds;

      final pubDate =
      PubDate(DateTime.fromMillisecondsSinceEpoch(oneDayMillis));

      expect(pubDate.antiquity, '1s');
    });

    test('return antiquity 1s if pub date ago is between 1 and 2 seconds', () {
      final int oneDayMillis = DateTime.now().millisecondsSinceEpoch -
          const Duration(milliseconds: 1200).inMilliseconds;

      final pubDate =
      PubDate(DateTime.fromMillisecondsSinceEpoch(oneDayMillis));

      expect(pubDate.antiquity, '1s');
    });

    test('return antiquity in seconds if pub date ago is greater than 1 second', () {
      final int oneDayMillis = DateTime.now().millisecondsSinceEpoch -
          const Duration(seconds: 23).inMilliseconds;

      final pubDate =
      PubDate(DateTime.fromMillisecondsSinceEpoch(oneDayMillis));

      expect(pubDate.antiquity, '23s');
    });

    test('return zero seconds if pub date ago is less than 0 seconds', () {
      final int oneDayMillis = DateTime.now().millisecondsSinceEpoch -
          const Duration(seconds: -5).inMilliseconds;

      final pubDate =
      PubDate(DateTime.fromMillisecondsSinceEpoch(oneDayMillis));

      expect(pubDate.antiquity, '0s');
    });
  });
}