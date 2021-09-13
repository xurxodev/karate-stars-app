import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';

abstract class CurrentNewsRepository {
  Future<List<CurrentNews>> getAll(ReadPolicy readPolicy);
}
