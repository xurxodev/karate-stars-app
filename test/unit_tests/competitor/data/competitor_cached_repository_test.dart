import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/remote/api_exceptions.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/competitors/data/competitor_cached_repository.dart';
import 'package:karate_stars_app/src/competitors/domain/boundaries/competitor_repository.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';
import 'package:mocktail/mocktail.dart';

import '../../../common/mothers/competitor_mother.dart';

class MockCacheDataSource extends Mock
    implements CacheableDataSource<Competitor> {}

class MockRemoteDataSource extends Mock
    implements ReadableDataSource<Competitor> {}

final _cacheDataSource = MockCacheDataSource();

final _remoteDataSource = MockRemoteDataSource();

late CompetitorRepository _repository;

void main() {
  setUp(() async {
    _repository =
        CompetitorCachedRepository(_cacheDataSource, _remoteDataSource);
  });

  group('CurrentNewsRepository', () {
    group('for cache first should', () {
      test('return data from cache if cache is valid', () async {
        final expectedData = givenThereAreValidDataInCache();

        givenThereAreSomeDataInRemote();

        final currentData = await _repository.getAll(ReadPolicy.cache_first);

        expect(currentData, expectedData);
      });
      test('return data from remote if cache is invalid', () async {
        givenThereAreInvalidDataInCache();
        final expectedData = givenThereAreSomeDataInRemote();

        final currentData = await _repository.getAll(ReadPolicy.cache_first);

        expect(currentData, expectedData);
      });
      test('return data from remote if cache has no data', () async {
        givenThereAreNotDataInCache();
        final expectedData = givenThereAreSomeDataInRemote();

        final currentData = await _repository.getAll(ReadPolicy.cache_first);

        expect(currentData, expectedData);
      });
      test('return data from cache if cache is invalid and remote throw error',
          () async {
        final expectedData = givenThereAreInvalidDataInCache();

        givenThatRemoteThrowException();

        final currentData = await _repository.getAll(ReadPolicy.cache_first);

        expect(currentData, expectedData);
      });
      test('throw exception if cache has not data and remote throw exception',
          () async {
        givenThereAreNotDataInCache();
        givenThatRemoteThrowException();

        expect(() => _repository.getAll(ReadPolicy.cache_first),
            throwsA(isInstanceOf<NetworkException>()));
      });
      test('throw exception if cache and remote throw exception', () async {
        givenThatCacheThrowException();
        givenThatRemoteThrowException();

        expect(() => _repository.getAll(ReadPolicy.cache_first),
            throwsA(isInstanceOf<NetworkException>()));
      });
    });
    group('for network first should', () {
      test('return data from remote even cache is valid', () async {
        givenThereAreValidDataInCache();

        final expectedNews = givenThereAreSomeDataInRemote();

        final currentNews = await _repository.getAll(ReadPolicy.network_first);

        expect(currentNews, expectedNews);
      });
      test('return data from cache if cache is invalid and remote throw error',
          () async {
        final expectedNews = givenThereAreValidDataInCache();
        givenThatRemoteThrowException();

        final currentNews = await _repository.getAll(ReadPolicy.network_first);

        expect(currentNews, expectedNews);
      });
      test('throw exception if cache has not data and remote throw exception',
          () async {
        givenThereAreNotDataInCache();
        givenThatRemoteThrowException();

        expect(() => _repository.getAll(ReadPolicy.network_first),
            throwsA(isInstanceOf<NetworkException>()));
      });
      test('throw exception if cache has not data and remote throw exception',
          () async {
        givenThatCacheThrowException();
        givenThatRemoteThrowException();

        expect(() => _repository.getAll(ReadPolicy.network_first),
            throwsA(isInstanceOf<NetworkException>()));
      });
    });
  });
}

List<Competitor> givenThereAreValidDataInCache() {
  final data = _localData();

  when(() => _cacheDataSource.getAll()).thenAnswer((_) => Future.value(data));
  when(() => _cacheDataSource.areValidValues())
      .thenAnswer((_) => Future.value(true));

  return data;
}

List<Competitor> givenThereAreInvalidDataInCache() {
  final data = _localData();

  when(() => _cacheDataSource.getAll()).thenAnswer((_) => Future.value(data));
  when(() => _cacheDataSource.areValidValues())
      .thenAnswer((_) => Future.value(false));
  when(() => _cacheDataSource.invalidate()).thenAnswer((_) => Future.value());
  when(() => _cacheDataSource.save(any())).thenAnswer((_) => Future.value());

  return data;
}

List<Competitor> givenThereAreSomeDataInRemote() {
  final data = _remoteData();

  when(() => _remoteDataSource.getAll()).thenAnswer((_) => Future.value(data));

  return data;
}

void givenThereAreNotDataInCache() {
  when(() => _cacheDataSource.getAll()).thenAnswer((_) => Future.value([]));
}

void givenThatRemoteThrowException() {
  when(() => _remoteDataSource.getAll()).thenThrow(NetworkException());
}

void givenThatCacheThrowException() {
  when(() => _cacheDataSource.getAll()).thenThrow(NetworkException());
}

List<Competitor> _localData() {
  return [CompetitorMother.stevenDaCosta(), CompetitorMother.joseEgea()];
}

List<Competitor> _remoteData() {
  return [
    CompetitorMother.stevenDaCosta(),
    CompetitorMother.joseEgea(),
    CompetitorMother.damianQuintero(),
    CompetitorMother.burakUygur()
  ];
}
