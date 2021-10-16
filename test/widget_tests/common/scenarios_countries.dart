import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/countries/domain/boundaries/country_repository.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks.dart';

void givenThereAreNoCountries() {
  final mockCountryRepository = MockCountryRepository();

  when(() => mockCountryRepository.getAll(ReadPolicy.cache_first))
      .thenAnswer((_) => Future.value([]));

  app_di.getIt
      .registerLazySingleton<CountryRepository>(() => mockCountryRepository);
}
