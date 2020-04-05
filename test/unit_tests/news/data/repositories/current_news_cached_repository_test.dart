import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/remote/api_exceptions.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/news/data/repositories/current_news_cached_repository.dart';
import 'package:karate_stars_app/src/news/domain/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:mockito/mockito.dart';

import '../../../../common/mothers/current_news_mother.dart';

class MockCacheDataSource extends Mock
    implements CacheableDataSource<CurrentNews> {}

class MockRemoteDataSource extends Mock
    implements ReadableDataSource<CurrentNews> {}

final _cacheDataSource = MockCacheDataSource();

final _remoteDataSource = MockRemoteDataSource();

CurrentNewsRepository _repository;

void main() {
  setUp(() async {
    _repository =
        CurrentNewsCachedRepository(_cacheDataSource, _remoteDataSource);
  });

  group('CurrentNewsRepository', () {
    group('for cache first should', () {
      test('return data from cache if cache is valid', () async {
        final expectedNews = givenThereAreValidDataInCache();

        givenThereAreSomeDataInRemote();

        final currentNews =
            await _repository.getCurrentNews(ReadPolicy.cache_first);

        expect(currentNews, expectedNews);
      });
      test('return data from remote if cache is invalid', () async {
        givenThereAreInvalidDataInCache();
        final expectedNews = givenThereAreSomeDataInRemote();

        final currentNews =
            await _repository.getCurrentNews(ReadPolicy.cache_first);

        expect(currentNews, expectedNews);
      });
      test('return data from remote if cache has no data', () async {
        givenThereAreNotDataInCache();
        final expectedNews = givenThereAreSomeDataInRemote();

        final currentNews =
            await _repository.getCurrentNews(ReadPolicy.cache_first);

        expect(currentNews, expectedNews);
      });
      test('return data from cache if cache is invalid and remote throw error',
          () async {
        final expectedNews = givenThereAreInvalidDataInCache();

        givenThatRemoteThrowException();

        final currentNews =
            await _repository.getCurrentNews(ReadPolicy.cache_first);

        expect(currentNews, expectedNews);
      });
      test('throw exception if cache has not data and remote throw exception',
          () async {
        givenThereAreNotDataInCache();
        givenThatRemoteThrowException();

        expect(() => _repository.getCurrentNews(ReadPolicy.cache_first),
            throwsA(isInstanceOf<NetworkException>()));
      });
      test('throw exception if cache and remote throw exception', () async {
        givenThatCacheThrowException();
        givenThatRemoteThrowException();

        expect(() => _repository.getCurrentNews(ReadPolicy.cache_first),
            throwsA(isInstanceOf<NetworkException>()));
      });
    });
    group('for network first should', () {
      test('return data from remote even cache is valid', () async {
        givenThereAreValidDataInCache();

        final expectedNews = givenThereAreSomeDataInRemote();

        final currentNews =
            await _repository.getCurrentNews(ReadPolicy.network_first);

        expect(currentNews, expectedNews);
      });
      test('return data from cache if cache is invalid and remote throw error',
          () async {
        final expectedNews = givenThereAreValidDataInCache();
        givenThatRemoteThrowException();

        final currentNews =
            await _repository.getCurrentNews(ReadPolicy.network_first);

        expect(currentNews, expectedNews);
      });
      test('throw exception if cache has not data and remote throw exception',
          () async {
        givenThereAreNotDataInCache();
        givenThatRemoteThrowException();

        expect(() => _repository.getCurrentNews(ReadPolicy.network_first),
            throwsA(isInstanceOf<NetworkException>()));
      });
      test('throw exception if cache has not data and remote throw exception',
          () async {
        givenThatCacheThrowException();
        givenThatRemoteThrowException();

        expect(() => _repository.getCurrentNews(ReadPolicy.network_first),
            throwsA(isInstanceOf<NetworkException>()));
      });
    });
  });
}

List<CurrentNews> givenThereAreValidDataInCache() {
  final currentNews = _localNews();

  when(_cacheDataSource.getAll()).thenAnswer((_) => Future.value(currentNews));
  when(_cacheDataSource.areValidValues()).thenAnswer((_) => Future.value(true));

  return currentNews;
}

List<CurrentNews> givenThereAreInvalidDataInCache() {
  final currentNews = _localNews();

  when(_cacheDataSource.getAll()).thenAnswer((_) => Future.value(currentNews));
  when(_cacheDataSource.areValidValues())
      .thenAnswer((_) => Future.value(false));

  return currentNews;
}

List<CurrentNews> givenThereAreSomeDataInRemote() {
  final currentNews = _remoteNews();

  when(_remoteDataSource.getAll()).thenAnswer((_) => Future.value(currentNews));

  return currentNews;
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

List<CurrentNews> _localNews() {
  return [CurrentNewsMother.madridHost2018()];
}

List<CurrentNews> _remoteNews() {
  return [
    CurrentNewsMother.madridHost2018(),
    CurrentNewsMother.quinteroNumber1(),
    CurrentNewsMother.stevenDaCostaVideo()
  ];
}
