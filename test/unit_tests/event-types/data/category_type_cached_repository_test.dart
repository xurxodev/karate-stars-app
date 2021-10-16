import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/event_types/data/event_type_cached_repository.dart';
import 'package:karate_stars_app/src/event_types/domain/entities/event_type.dart';
import '../../../common/mothers/event_types_mother.dart';
import '../../common/data/repositories/common_cached_repository_test.dart';

List<EventType> _localData() {
  return [worldChampionships()];
}

List<EventType> _remoteData() {
  return [worldChampionships(), europeanChampionships()];
}

EventTypeCachedRepository repositoryFactory(
    CacheableDataSource<EventType> cache, ReadableDataSource<EventType> remote) {
  return EventTypeCachedRepository(cache, remote);
}

void main() {
  executeRepositoryTests(repositoryFactory, _localData(), _remoteData());
}