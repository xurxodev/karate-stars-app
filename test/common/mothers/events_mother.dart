import 'package:karate_stars_app/src/events/domain/entities/event.dart';

Event europeanChampionships2021() {
  return Event(
      'W9p4KDNo1Vi', 'European Championships Porec 2021', 'FEJ08kkHhqi', 2021);
}

Event olympicGames2020() {
  return Event('lTWNoZjuBqd', 'Olympic Games Tokyo 2020', 'Z8JRebUhjRB', 2021);
}

List<Event> allEvents() {
  return [europeanChampionships2021(), olympicGames2020()];
}
