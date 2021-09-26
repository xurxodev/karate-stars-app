import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/countries/domain/entities/country.dart';

abstract class CountryRepository {
  Future<List<Country>> getAll(ReadPolicy readPolicy);
}
