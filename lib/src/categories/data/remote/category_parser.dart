import 'package:karate_stars_app/src/categories/domain/entities/category.dart';

class CategoryParser {
  List<Category> parse(List<dynamic> json) {
    return json.map((jsonItem) => _parseCountry(jsonItem)).toList();
  }

  Category _parseCountry(Map<String, dynamic> jsonData) {
    return Category(jsonData['id'], jsonData['name'], jsonData['typeId'],
        jsonData['main'] ?? true, jsonData['paraKarate'] ?? false);
  }
}
