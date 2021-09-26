import 'package:karate_stars_app/src/countries/domain/entities/country.dart';

Country spain() {
  return Country(
      'UCyMZcbtB4u',
      'Spain',
      'es',
      'http://www.karatestarsapp.com/app/flags/es.png');
}

Country croatia() {
  return Country(
      'PAuqgX3CfjI',
      'Croatia',
      'hr',
      'http://www.karatestarsapp.com/app/flags/hr.png');
}

Country austria() {
  return Country(
      'uhsEK0d5iue',
      'Austria',
      'at',
      'http://www.karatestarsapp.com/app/flags/at.png');
}

Country azerbaijan() {
  return Country(
      'uIaQv0JlN5n',
      'Azerbaijan',
      'az',
      'http://www.karatestarsapp.com/app/flags/az.png');
}

List<Country> allCountries() {
  return [spain(), croatia(), austria(), azerbaijan()];
}