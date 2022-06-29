import 'package:karate_stars_app/src/rankings/domain/entities/ranking.dart';

Ranking wkfRanking() {
  return Ranking(
      'vnsabLUirBx',
      'WKF Ranking',
      'https://storage.googleapis.com/karatestars-1261.appspot.com/feeds/l1oxUWoZhdL.png',
      'http://setopen.sportdata.org/wkfranking/ranking_main.php',
      'http://setopen.sportdata.org/wkfranking/ranking_main_xml.php',
      'ranking_category_id',
      ['X4CZx1DLFPc', 'TmnEeLzo5ZC']);
}

Ranking europeanGamesStanding() {
  return Ranking(
      'K6MwDuZ5r1X',
      'European Games 2023 Standings',
      'https://www.european-games.org/wp-content/uploads/2016/09/eg-logo-bola.png',
      'http://setopen.sportdata.org/wkfranking/standing_egpoland2023.php',
      null,
      null,
      []);
}

List<Ranking> allRankings() {
  return [wkfRanking(), europeanGamesStanding()];
}
