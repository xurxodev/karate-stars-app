import 'package:karate_stars_app/src/competitors/domain/entities/achievement.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';

class CompetitorMother {
  static Competitor stevenDaCosta() {
    final achievements = [
      Achievement('World Championships', [
        AchievementDetail('Linz 2016', 'Kumite -67', 3),
        AchievementDetail('Linz 2016', 'Team Kumite', 3)
      ]),
      Achievement('European Championships', [
        AchievementDetail('Montpellier 2016', 'Kumite -67', 1),
        AchievementDetail('Montpellier 2016', 'Team Kumite', 3)
      ])
    ];

    final links = CompetitorLinks(
        null,
        'https://twitter.com/Steven_DaCosta',
        'https://www.facebook.com/Steven-Da-Costa-714387352001605',
        'https://www.instagram.com/dacosta_steven');

    return Competitor(
        'WXmXikMk',
        'Steven Da Costa',
        'Steven Da Costa (born January 23, 1997) is...',
        'fr',
        'EFWSI57G',
        'http://www.karatestarsapp.com/app/images/steven_da_costa.jpg',
        true,
        false,
        links,
        achievements);
  }

  static Competitor joseEgea() {

    final achievements = [
      Achievement('World Championships', [
        AchievementDetail('Mexico City 1990', 'Kumite -80', 1),
        AchievementDetail('Granada 1992', 'Kumite -80', 1)
      ]),
      Achievement('European Championships', [
        AchievementDetail('Titograd 1989', 'Kumite -80', 1),
        AchievementDetail('Vienna 1990', 'Kumite -80', 1)
      ])
    ];

    final links = CompetitorLinks(
        null,
        null,
        'https://www.facebook.com/josemanuel.egeacaceres',
        null);

    return Competitor(
        'w5ePRMfj',
        'Jose Manuel Egea',
        'José Manuel Egea is a Spanish karateka, ...',
        'es',
        'EFWSI57G',
        'http://www.karatestarsapp.com/app/images/jose_manuel_egea.jpg',
        false,
        true,
        links,
        achievements);
  }

  static Competitor damianQuintero() {
    final achievements = [
      Achievement('World Championships', [
        AchievementDetail('"Linz 2016', 'Team kata', 3),
        AchievementDetail('Linz 2016', 'Individual Kata', 2)
      ]),
      Achievement('European Championships', [
        AchievementDetail('Montpellier 2016', 'Individual Kata', 1),
        AchievementDetail('Kocaeli 2017', 'Individual Kata', 1)
      ])
    ];

    final links = CompetitorLinks(
        'http://www.damianquintero.com/',
        'https://twitter.com/DamianHQuintero',
        'https://www.facebook.com/DamianQuintero',
        'https://www.instagram.com/damianquintero');

        return Competitor(
        'j3W6HKw5',
        'Damian Quintero',
        'Damian Quintero was born on July 4 ...',
        'es',
        '1xSqqSPN',
        'http://www.karatestarsapp.com/app/images/damian_quintero.jpg',
        true,
        false,
        links,
        achievements);
  }

  static Competitor burakUygur() {
    final achievements = [
      Achievement('European Championships', [
        AchievementDetail('Istambul 2015', 'Kumite -67', 2),
        AchievementDetail('Kocaeli 2017', 'Kumite -67', 1)
      ])
    ];

    final links = CompetitorLinks(
        null,
        'https://twitter.com/_burakuygur',
        null,
        null);

    return Competitor(
        'eyEK9QbQ',
        'Burak Uygur',
        'Burak Uygur (born April 14, 1995) is a European Games...',
        'tr',
        'EFWSI57G',
        'http://www.karatestarsapp.com/app/images/burak_uygur.jpg',
        true,
        false,
        links,
        achievements);
  }

  static List<Competitor> all() {
    return [stevenDaCosta(), joseEgea(), damianQuintero(), burakUygur()];
  }
}
