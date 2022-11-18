import 'package:karate_stars_app/src/global_di.dart' as app_di;
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/competitors/domain/boundaries/competitor_repository.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks.dart';

void givenThereAreNoCompetitors() {
  final mockCompetitorRepository = MockCompetitorRepository();

  when(() => mockCompetitorRepository.getAll(ReadPolicy.cache_first))
      .thenAnswer((_) => Future.value([]));

  app_di.getIt.registerLazySingleton<CompetitorRepository>(
      () => mockCompetitorRepository);
}
