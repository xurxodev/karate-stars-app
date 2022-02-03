import 'package:karate_stars_app/src/common/data/local/DataBaseMapper.dart';
import 'package:karate_stars_app/src/countries/data/local/country_db.dart';
import 'package:karate_stars_app/src/countries/domain/entities/country.dart';

class CountryMapper implements DataBaseMapper<Country, CountryDB> {
  @override
  Country mapToDomain(CountryDB modelDB) {
    return Country(modelDB.id, modelDB.name, modelDB.iso2, modelDB.image);
  }

  @override
  CountryDB mapToDB(Country entity) {
    return CountryDB(
      entity.id,
      entity.name,
      entity.iso2,
      entity.image,
      DateTime.now().toIso8601String(),
    );
  }
}
