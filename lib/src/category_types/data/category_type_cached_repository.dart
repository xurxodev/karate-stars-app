import 'package:karate_stars_app/src/category_types/domain/boundaries/category_type_repository.dart';
import 'package:karate_stars_app/src/category_types/domain/entities/category_type.dart';
import 'package:karate_stars_app/src/common/data/cached_repository.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';

class CategoryTypeCachedRepository extends CachedRepository<CategoryType>
    implements CategoryTypeRepository {
  CategoryTypeCachedRepository(CacheableDataSource<CategoryType> cacheDataSource,
      ReadableDataSource<CategoryType> remoteDataSource)
      : super(cacheDataSource, remoteDataSource);

  @override
  Future<List<CategoryType>> getAll(ReadPolicy readPolicy) {
    return super.getAll(readPolicy);
  }
}
