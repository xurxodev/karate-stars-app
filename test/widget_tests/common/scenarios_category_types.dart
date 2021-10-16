import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/category_types/domain/boundaries/category_type_repository.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks.dart';

void givenThereAreNoCategoryTypes() {
  final mockCategoryTypeRepository = MockCategoryTypeRepository();

  when(() => mockCategoryTypeRepository.getAll(ReadPolicy.cache_first))
      .thenAnswer((_) => Future.value([]));

  app_di.getIt.registerLazySingleton<CategoryTypeRepository>(
      () => mockCategoryTypeRepository);
}
