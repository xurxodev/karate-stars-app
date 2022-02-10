import 'package:karate_stars_app/src/events/domain/entities/event.dart';

Event europeanChampionships2021() {
  return Event(
      'W9p4KDNo1Vi',
      'European Championships Porec 2021',
      'FEJ08kkHhqi',
      DateTime.parse('2021-08-05T00:00:00.000Z'),
      DateTime.parse('2021-08-05T00:00:00.000Z'),
      null);
}

Event olympicGames2020() {
  return Event(
      'lTWNoZjuBqd',
      'Olympic Games Tokyo 2020',
      'Z8JRebUhjRB',
      DateTime.parse('2021-08-05T00:00:00.000Z'),
      DateTime.parse('2021-08-05T00:00:00.000Z'),
      'https://olympics.com/es/olympic-games/tokyo-2020/results/karate');
}

List<Event> allEvents() {
  return [europeanChampionships2021(), olympicGames2020()];
}
