import 'package:karate_stars_app/src/categories/domain/boundaries/category_repository.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/global_di.dart' as app_di;
import 'package:mocktail/mocktail.dart';

import 'mocks.dart';

void givenThereAreNoCategories() {
  final mockCategoryRepository = MockCategoryRepository();

  when(() => mockCategoryRepository.getAll(ReadPolicy.cache_first))
      .thenAnswer((_) => Future.value([]));

  app_di.getIt
      .registerLazySingleton<CategoryRepository>(() => mockCategoryRepository);
}
