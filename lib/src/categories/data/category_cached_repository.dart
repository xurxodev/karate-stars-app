import 'package:karate_stars_app/src/categories/domain/boundaries/category_repository.dart';
import 'package:karate_stars_app/src/categories/domain/entities/category.dart';
import 'package:karate_stars_app/src/common/data/cached_repository.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';

class CategoryCachedRepository extends CachedRepository<Category>
    implements CategoryRepository {
  CategoryCachedRepository(CacheableDataSource<Category> cacheDataSource,
      ReadableDataSource<Category> remoteDataSource)
      : super(cacheDataSource, remoteDataSource);

  @override
  Future<List<Category>> getAll(ReadPolicy readPolicy) {
    return super.getAll(readPolicy);
  }
}
