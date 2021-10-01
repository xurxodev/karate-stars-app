import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/countries/domain/boundaries/country_repository.dart';
import 'package:karate_stars_app/src/countries/domain/entities/country.dart';

class GetCountriesUseCase {
  final CountryRepository _countryRepository;

  GetCountriesUseCase(this._countryRepository);

  Future<List<Country>> execute(ReadPolicy readPolicy) async {
    final countries = await _countryRepository.getAll(readPolicy);

    countries.sort((a, b) => a.name.compareTo(b.name));

    return countries;
  }
}
