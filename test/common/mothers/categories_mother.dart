import 'package:karate_stars_app/src/categories/domain/entities/category.dart';

Category maleKata() {
  return Category('KqVrbhbJ72W', 'Male Kata', 'qWPs4i1e78g');
}

Category femaleKata() {
  return Category('uAwCwvaoUgg', 'Female Kata', 'qWPs4i1e78g');
}

Category maleTeamKumite() {
  return Category('QihGhQpPpiI', 'Male Team Kumite', 'Gps5nVcCdjV');
}

Category femaleTeamKumite() {
  return Category('kY6eNgWEXbw', 'Female Team Kumite', 'Gps5nVcCdjV');
}

List<Category> allCategoryTypes() {
  return [maleKata(), maleTeamKumite(), femaleKata(), femaleTeamKumite()];
}
