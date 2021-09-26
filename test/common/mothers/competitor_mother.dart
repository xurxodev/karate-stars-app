import 'package:karate_stars_app/src/competitors/domain/entities/achievement.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';

Competitor stevenDaCosta() {
  final achievements = [
    Achievement('lTWNoZjuBqd', 'wa8Xgi22vUo', 1),
    Achievement('W9p4KDNo1Vi', 'wa8Xgi22vUo', 3)
  ];

  final links = [
    CompetitorLink('https://twitter.com/Steven_DaCosta', SocialLink.twitter),
    CompetitorLink('https://www.facebook.com/Steven-Da-Costa-714387352001605',
        SocialLink.facebook),
    CompetitorLink(
        'https://www.instagram.com/dacosta_steven', SocialLink.instagram)
  ];

  return Competitor(
      'WhVviRyQwlc',
      'Steven',
      'Da Costa',
      'FRA412',
      'Steven Da Costa (born January 23, 1997) is...',
      'JZlQc0xbmlp',
      'categoryId',
      'https://storage.googleapis.com/karatestars-1261.appspot.com/competitors/PMHlnTxTdXQ.jpeg',
      true,
      false,
      links,
      achievements);
}

Competitor joseEgea() {
  final achievements = [
  Achievement('MYL8ZJseBkW', 'DDexNXai9Cn', 3),
  Achievement('CEdI81ejHhq', 'X3WKhryS14n', 3)];

  final links = [
    CompetitorLink('https://www.facebook.com/josemanuel.egeacaceres',
        SocialLink.facebook),
  ];

  return Competitor(
      'w5ePRMfj',
      'Jose Manuel',
      'Egea Caceres',
      'ESP000',
      'José Manuel Egea is a Spanish karateka, ...',
      'UCyMZcbtB4u',
      'DDexNXai9Cn',
      'https://storage.googleapis.com/karatestars-1261.appspot.com/competitors/gBPQPnFgqSc.jpeg',
      false,
      true,
      links,
      achievements);
}

Competitor damianQuintero() {
  final achievements = [
    Achievement('W9p4KDNo1Vi', 'KqVrbhbJ72W', 2),
    Achievement('lTWNoZjuBqd', 'KqVrbhbJ72W', 2)
  ];

  final links = [
    CompetitorLink('http://www.damianquintero.com/', SocialLink.web),
    CompetitorLink('https://twitter.com/DamianHQuintero',
        SocialLink.twitter)
  ];

  return Competitor(
      'vWlMQ4Wn5mD',
      'Damian Hugo',
      'Quintero Capdevila',
      'ESP173',
      'Damian Quintero was born on July 4 ...',
      'UCyMZcbtB4u',
      'KqVrbhbJ72W',
      'https://storage.googleapis.com/karatestars-1261.appspot.com/competitors/MVER5GY0SFn.jpeg',
      false,
      true,
      links,
      achievements);
}

Competitor burakUygur() {
  final achievements = [
    Achievement('L8MRg5oXpbD', 'wa8Xgi22vUo', 2),
    Achievement('fbuxCI847Hm', 'wa8Xgi22vUo', 1)
  ];

  final links = [
    CompetitorLink('https://www.instagram.com/_burakuygur', SocialLink.instagram),
    CompetitorLink('https://twitter.com/_burakuygur', SocialLink.twitter)
  ];

  return Competitor(
      'Xmdl9eUji1a',
      'Burako',
      'Uygur',
      'TUR492',
      'Burak Uygur (born April 14, 1995) is a European Games...',
      'TRxEGfqs7S7',
      'wa8Xgi22vUo',
       'https://storage.googleapis.com/karatestars-1261.appspot.com/competitors/cyaNlRCq0Su.jpeg',
      true,
      false,
      links,
      achievements);
}

List<Competitor> allCompetitors() {
  return [stevenDaCosta(), joseEgea(), damianQuintero(), burakUygur()];
}
