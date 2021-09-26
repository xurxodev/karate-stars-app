import 'package:karate_stars_app/src/countries/domain/entities/country.dart';

class CountryParser {
  List<Country> parse(List<dynamic> json) {
    return json.map((jsonItem) => _parseCountry(jsonItem)).toList();
  }

  Country _parseCountry(Map<String, dynamic> jsonData) {
    return Country(
        jsonData['id'], jsonData['name'], jsonData['iso2'], jsonData['image']);
  }
}
