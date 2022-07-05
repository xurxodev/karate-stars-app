import 'package:flutter_test/flutter_test.dart';
import 'package:karate_stars_app/src/common/data/cached_partial_repository.dart';
import 'package:karate_stars_app/src/common/data/local/cache_data_source.dart';
import 'package:karate_stars_app/src/common/data/local/cacheable_partial_hive_data_source.dart';
import 'package:karate_stars_app/src/common/data/remote/api_exceptions.dart';
import 'package:karate_stars_app/src/common/data/remote/filterable_api_data_source.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/domain/types.dart';
import 'package:mocktail/mocktail.dart';

class MockCacheDataSource<Entity extends Identifiable,
        ModelDB extends CacheablePartialModelDB> extends Mock
    implements CacheablePartialDataSource<Entity, ModelDB> {}

class MockRemoteDataSource<Entity> extends Mock
    implements FilterableApiDataSource<Entity> {}

void executePartialRepositoryTests<Entity extends Identifiable,
        ModelDB extends CacheablePartialModelDB>(
    Function(CacheablePartialDataSource<Entity, ModelDB>,
        FilterableApiDataSource<Entity>)
        repositoryFactory,
    List<Entity> localPartialData,
    List<Entity> remotePartialData,
    Map<String, dynamic> filters
    ) {
  late CachedPartialRepository<Entity, ModelDB> _repository;
  final _cacheDataSource = MockCacheDataSource<Entity, ModelDB>();

  final _remoteDataSource = MockRemoteDataSource<Entity>();

  List<Entity> givenThereAreValidDataInCache() {
    when(() => _cacheDataSource.getByFilters(filters))
        .thenAnswer((_) => Future.value(localPartialData));

    when(() => _cacheDataSource.areValidValues(localPartialData))
        .thenAnswer((_) => Future.value(true));

    return localPartialData;
  }

  List<Entity> givenThereAreInvalidDataInCache() {
    when(() => _cacheDataSource.getByFilters(filters))
        .thenAnswer((_) => Future.value(localPartialData));
    when(() => _cacheDataSource.areValidValues(any()))
        .thenAnswer((_) => Future.value(false));
    when(() => _cacheDataSource.invalidate(any())).thenAnswer((_) => Future.value());
    when(() => _cacheDataSource.save(any())).thenAnswer((_) => Future.value());

    return localPartialData;
  }

  List<Entity> givenThereAreSomeDataInRemote() {
    when(() => _remoteDataSource.getByFilters(filters))
        .thenAnswer((_) => Future.value(remotePartialData));

    return remotePartialData;
  }

  void givenThereAreNotDataInCache() {
    when(() => _cacheDataSource.getByFilters(filters)).thenAnswer((_) => Future.value([]));
  }

  void givenThatRemoteThrowException() {
    when(() => _remoteDataSource.getByFilters(filters)).thenThrow(NetworkException());
  }

  void givenThatCacheThrowException() {
    when(() => _cacheDataSource.getByFilters(filters)).thenThrow(NetworkException());
  }

  setUp(() async {
    _repository = repositoryFactory(_cacheDataSource, _remoteDataSource);
  });

  group('Repository', () {
    group('for cache first should', () {
      test('return data from cache if cache is valid', () async {
        final expectedData = givenThereAreValidDataInCache();

        givenThereAreSomeDataInRemote();

        final currentData = await _repository.getByFilters(ReadPolicy.cache_first,filters);

        expect(currentData, expectedData);
      });
      test('return data from remote if cache is invalid', () async {
        givenThereAreInvalidDataInCache();
        final expectedData = givenThereAreSomeDataInRemote();

        final currentData = await _repository.getByFilters(ReadPolicy.cache_first,filters);

        expect(currentData, expectedData);
      });
      test('return data from remote if cache has no data', () async {
        givenThereAreNotDataInCache();
        final expectedData = givenThereAreSomeDataInRemote();

        final currentData = await _repository.getByFilters(ReadPolicy.cache_first,filters);

        expect(currentData, expectedData);
      });
      test('return data from cache if cache is invalid and remote throw error',
          () async {
        final expectedData = givenThereAreInvalidDataInCache();

        givenThatRemoteThrowException();

        final currentData = await _repository.getByFilters(ReadPolicy.cache_first,filters);

        expect(currentData, expectedData);
      });
      test('throw exception if cache has not data and remote throw exception',
          () async {
        givenThereAreNotDataInCache();
        givenThatRemoteThrowException();

        expect(() => _repository.getByFilters(ReadPolicy.cache_first, filters),
            throwsA(isInstanceOf<NetworkException>()));
      });
      test('throw exception if cache and remote throw exception', () async {
        givenThatCacheThrowException();
        givenThatRemoteThrowException();

        expect(() => _repository.getByFilters(ReadPolicy.cache_first, filters),
            throwsA(isInstanceOf<NetworkException>()));
      });
    });
    group('for network first should', () {
      test('return data from remote even cache is valid', () async {
        givenThereAreValidDataInCache();

        final expectedData = givenThereAreSomeDataInRemote();

        final currentData = await _repository.getByFilters(ReadPolicy.network_first,filters);

        expect(currentData, expectedData);
      });
      test('return data from cache if cache is invalid and remote throw error',
          () async {
        final expectedData = givenThereAreValidDataInCache();
        givenThatRemoteThrowException();

        final currentData = await _repository.getByFilters(ReadPolicy.network_first,filters);

        expect(currentData, expectedData);
      });
      test('throw exception if cache has not data and remote throw exception',
          () async {
        givenThereAreNotDataInCache();
        givenThatRemoteThrowException();

        expect(() => _repository.getByFilters(ReadPolicy.network_first,filters),
            throwsA(isInstanceOf<NetworkException>()));
      });
      test('throw exception if cache has not data and remote throw exception',
          () async {
        givenThatCacheThrowException();
        givenThatRemoteThrowException();

        expect(() => _repository.getByFilters(ReadPolicy.network_first,filters),
            throwsA(isInstanceOf<NetworkException>()));
      });
    });
  });
}

// To avoid method main not found
void main() {}
