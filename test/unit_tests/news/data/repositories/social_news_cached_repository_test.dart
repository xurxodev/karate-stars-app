import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/remote/api_exceptions.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/news/data/repositories/social_news_cached_repository.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/domain/social_news_repository.dart';
import 'package:mockito/mockito.dart';

import '../common/social_news_mother.dart';

class MockCacheDataSource extends Mock
    implements CacheableDataSource<SocialNews> {}

class MockRemoteDataSource extends Mock
    implements ReadableDataSource<SocialNews> {}

final _cacheDataSource = MockCacheDataSource();

final _remoteDataSource = MockRemoteDataSource();

SocialNewsRepository _repository;

void main() {
  setUp(() async {
    _repository =
        SocialNewsCachedRepository(_cacheDataSource, _remoteDataSource);
  });

  group('CurrentNewsRepository', () {
    group('for cache first should', () {
      test('return data from cache if cache is valid', () async {
        final expectedNews = givenThereAreValidDataInCache();

        givenThereAreSomeDataInRemote();

        final currentNews =
            await _repository.getSocialNews(ReadPolicy.cache_first);

        expect(currentNews, expectedNews);
      });
      test('return data from remote if cache is invalid', () async {
        givenThereAreInvalidDataInCache();
        final expectedNews = givenThereAreSomeDataInRemote();

        final currentNews =
        await _repository.getSocialNews(ReadPolicy.cache_first);

        expect(currentNews, expectedNews);
      });
      test('return data from remote if cache has no data', () async {
        givenThereAreNotDataInCache();
        final expectedNews = givenThereAreSomeDataInRemote();

        final currentNews =
        await _repository.getSocialNews(ReadPolicy.cache_first);

        expect(currentNews, expectedNews);
      });
      test('return data from cache if cache is invalid and remote throw error',
          () async {
        final expectedNews = givenThereAreInvalidDataInCache();

        givenThatRemoteThrowException();

        final currentNews =
            await _repository.getSocialNews(ReadPolicy.cache_first);

        expect(currentNews, expectedNews);
      });
      test('throw exception if cache has not data and remote throw exception',
          () async {
        givenThereAreNotDataInCache();
        givenThatRemoteThrowException();

        expect(() => _repository.getSocialNews(ReadPolicy.cache_first),
            throwsA(isInstanceOf<NetworkException>()));
      });
      test('throw exception if cache and remote throw exception', () async {
        givenThatCacheThrowException();
        givenThatRemoteThrowException();

        expect(() => _repository.getSocialNews(ReadPolicy.cache_first),
            throwsA(isInstanceOf<NetworkException>()));
      });
    });
    group('for network first should', () {
      test('return data from remote even cache is valid', () async {
        givenThereAreValidDataInCache();

        final expectedNews = givenThereAreSomeDataInRemote();

        final currentNews =
            await _repository.getSocialNews(ReadPolicy.network_first);

        expect(currentNews, expectedNews);
      });
      test('return data from cache if cache is invalid and remote throw error',
          () async {
        final expectedNews = givenThereAreValidDataInCache();
        givenThatRemoteThrowException();

        final currentNews =
            await _repository.getSocialNews(ReadPolicy.network_first);

        expect(currentNews, expectedNews);
      });
      test('throw exception if cache has not data and remote throw exception',
          () async {
        givenThereAreNotDataInCache();
        givenThatRemoteThrowException();

        expect(() => _repository.getSocialNews(ReadPolicy.network_first),
            throwsA(isInstanceOf<NetworkException>()));
      });
      test('throw exception if cache has not data and remote throw exception',
          () async {
        givenThatCacheThrowException();
        givenThatRemoteThrowException();

        expect(() => _repository.getSocialNews(ReadPolicy.network_first),
            throwsA(isInstanceOf<NetworkException>()));
      });
    });
  });
}

List<SocialNews> givenThereAreValidDataInCache() {
  final socialNews = SocialNewsMother.local();

  when(_cacheDataSource.getAll()).thenAnswer((_) => Future.value(socialNews));
  when(_cacheDataSource.areValidValues()).thenAnswer((_) => Future.value(true));

  return socialNews;
}

List<SocialNews> givenThereAreInvalidDataInCache() {
  final socialNews = SocialNewsMother.local();

  when(_cacheDataSource.getAll()).thenAnswer((_) => Future.value(socialNews));
  when(_cacheDataSource.areValidValues())
      .thenAnswer((_) => Future.value(false));

  return socialNews;
}

List<SocialNews> givenThereAreSomeDataInRemote() {
  final socialNews = SocialNewsMother.remote();

  when(_remoteDataSource.getAll()).thenAnswer((_) => Future.value(socialNews));

  return socialNews;
}

void givenThereAreNotDataInCache() {
  when(_cacheDataSource.getAll()).thenAnswer((_) => Future.value([]));
}

void givenThatRemoteThrowException() {
  when(_remoteDataSource.getAll()).thenThrow(NetworkException());
}

void givenThatCacheThrowException() {
  when(_cacheDataSource.getAll()).thenThrow(NetworkException());
}
