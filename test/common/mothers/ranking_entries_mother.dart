import 'package:karate_stars_app/src/rankings/domain/entities/rankingEntry.dart';

RankingEntry wkfRankingKataMaleRank1() {
  return RankingEntry(
      'J0OzcumsPiA',
      'vnsabLUirBx',
      1,
      'SPAIN',
      'ESP',
      'DAMIAN HUGO QUINTERO CAPDEVILA',
      'DAMIAN HUGO',
      'QUINTERO CAPDEVILA',
      'ESP173',
      'https://www.sportdata.org/wkf/competitor_pics/1288.jpg',
      6000.0,
      'EKF',
      'KqVrbhbJ72W',
      '489');
}

RankingEntry wkfRankingKataMaleRank2() {
  return RankingEntry(
      'biASWu1roHd',
      'vnsabLUirBx',
      2,
      'TURKEY',
      'TUR',
      'ALI SOFUOGLU',
      'ALI',
      'SOFUOGLU',
      'TUR353',
      'https://www.sportdata.org/wkf/competitor_pics/832.jpg',
      5437.5,
      'AKF',
      'KqVrbhbJ72W',
      '489');
}

RankingEntry wkfRankingKataFemaleRank1() {
  return RankingEntry(
      'D4Kkh9WvwDN',
      'vnsabLUirBx',
      1,
      'JAPAN',
      'JPN',
      'HIKARU ONO',
      'HIKARU',
      'ONO',
      'JPN2191',
      'https://www.sportdata.org/wkf/competitor_pics/30919.jpg',
      7095.0,
      'AKF',
      'uAwCwvaoUgg',
      '490');
}

RankingEntry wkfRankingKataFemaleRank2() {
  return RankingEntry(
      'qy6IE2Ci9iY',
      'vnsabLUirBx',
      2,
      'SPAIN',
      'ESP',
      'SANDRA SANCHEZ JAIME',
      'SANDRA',
      'SANCHEZ JAIME',
      'ESP198',
      'https://www.sportdata.org/wkf/competitor_pics/6752.jpg',
      6930.0,
      'EKF',
      'uAwCwvaoUgg',
      '490');
}

List<RankingEntry> allRankingEntries() {
  return [
    wkfRankingKataMaleRank1(),
    wkfRankingKataMaleRank2(),
    wkfRankingKataFemaleRank1(),
    wkfRankingKataFemaleRank2()
  ];
}
