import 'package:karate_stars_app/src/rankings/domain/entities/rankingEntry.dart';

abstract class Parser<Entity>{
  List<Entity> parse(List<dynamic> json);
}

class RankingEntryParser implements Parser<RankingEntry>{
  @override
  List<RankingEntry> parse(List<dynamic> json) {
    return json.map((jsonItem) => _parse(jsonItem)).toList();
  }

  RankingEntry _parse(Map<String, dynamic> jsonData) {
    return RankingEntry(
        jsonData['id'],
        jsonData['rankingId'],
        jsonData['rank'],
        jsonData['country'],
        jsonData['countryCode'],
        jsonData['name'],
        jsonData['firstName'],
        jsonData['lastName'],
        jsonData['wkfId'],
        jsonData['photo'],
        double.parse(jsonData['totalPoints'].toString()),
        jsonData['continentalCode'],
        jsonData['categoryId'],
        jsonData['categoryWkfId']);
  }
}
