import 'package:karate_stars_app/src/rankings/domain/entities/ranking.dart';

class RankingParser {
  List<Ranking> parse(List<dynamic> json) {
    return json.map((jsonItem) => _parse(jsonItem)).toList();
  }

  Ranking _parse(Map<String, dynamic> jsonData) {
    return Ranking(
        jsonData['id'],
        jsonData['name'],
        jsonData['image'],
        jsonData['webUrl'],
        jsonData['apiUrl'],
        jsonData['categoryParameter'],
        (jsonData['categories'] as List<dynamic>).cast<String>());
  }
}
