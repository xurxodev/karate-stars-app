import 'package:karate_stars_app/src/category_types/domain/entities/category_type.dart';

CategoryType kata() {
  return CategoryType('qWPs4i1e78g', 'Kata');
}

CategoryType kumite() {
  return CategoryType('Gps5nVcCdjV', 'Kumite');
}

List<CategoryType> allCategoryTypes() {
  return [kata(), kumite()];
}
