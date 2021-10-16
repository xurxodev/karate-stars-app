import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/events/data/event_cached_repository.dart';
import 'package:karate_stars_app/src/events/domain/entities/event.dart';
import '../../../common/mothers/events_mother.dart';
import '../../common/data/repositories/common_cached_repository_test.dart';

List<Event> _localData() {
  return [europeanChampionships2021()];
}

List<Event> _remoteData() {
  return [europeanChampionships2021(), olympicGames2020()];
}

EventCachedRepository repositoryFactory(
    CacheableDataSource<Event> cache, ReadableDataSource<Event> remote) {
  return EventCachedRepository(cache, remote);
}

void main() {
  executeRepositoryTests(repositoryFactory, _localData(), _remoteData());
}
