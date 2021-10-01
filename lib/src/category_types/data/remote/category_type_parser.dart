import 'package:karate_stars_app/src/category_types/domain/entities/category_type.dart';

class CategoryTypeParser {
  List<CategoryType> parse(List<dynamic> json) {
    return json.map((jsonItem) => _parseCountry(jsonItem)).toList();
  }

  CategoryType _parseCountry(Map<String, dynamic> jsonData) {
    return CategoryType(jsonData['id'], jsonData['name']);
  }
}
