import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/data/cached_repository.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/remote/api_exceptions.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:mocktail/mocktail.dart';

class MockCacheDataSource<T> extends Mock
    implements CacheableDataSource<T> {}

class MockRemoteDataSource<T> extends Mock
    implements ReadableDataSource<T> {}

void executeRepositoryTests<T>(Function(CacheableDataSource<T>, ReadableDataSource<T>) repositoryFactory,
    List<T> localData, List<T> remoteData) {

  late CachedRepository<T> _repository;
  final _cacheDataSource = MockCacheDataSource<T>();

  final _remoteDataSource = MockRemoteDataSource<T>();

  List<T> givenThereAreValidDataInCache() {
    when(() => _cacheDataSource.getAll())
        .thenAnswer((_) => Future.value(localData));
    when(() => _cacheDataSource.areValidValues())
        .thenAnswer((_) => Future.value(true));

    return localData;
  }

  List<T> givenThereAreInvalidDataInCache() {
    when(() => _cacheDataSource.getAll())
        .thenAnswer((_) => Future.value(localData));
    when(() => _cacheDataSource.areValidValues())
        .thenAnswer((_) => Future.value(false));
    when(() => _cacheDataSource.invalidate()).thenAnswer((_) => Future.value());
    when(() => _cacheDataSource.save(any())).thenAnswer((_) => Future.value());

    return localData;
  }

  List<T> givenThereAreSomeDataInRemote() {
    when(() => _remoteDataSource.getAll())
        .thenAnswer((_) => Future.value(remoteData));

    return remoteData;
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

  setUp(() async {
    _repository =
        repositoryFactory(_cacheDataSource, _remoteDataSource);
  });

  group('Repository', () {
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

        final expectedData = givenThereAreSomeDataInRemote();

        final currentData = await _repository.getAll(ReadPolicy.network_first);

        expect(currentData, expectedData);
      });
      test('return data from cache if cache is invalid and remote throw error',
          () async {
        final expectedData = givenThereAreValidDataInCache();
        givenThatRemoteThrowException();

        final currentData = await _repository.getAll(ReadPolicy.network_first);

        expect(currentData, expectedData);
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

// To avoid method main not found
void main() {
}

