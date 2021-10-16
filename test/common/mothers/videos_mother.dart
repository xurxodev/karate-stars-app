import 'package:karate_stars_app/src/videos/domain/entities/video.dart';

Video sandraTokyo2020() {
  final links = [
    VideoLink('qE18hRFs8V8', VideoLinkType.youtube),
  ];

  return Video(
      'RB5VUcdkd1l',
      'Olympic Games 2020',
      'S. Sanchez vs K. Shimizu',
      'Final Female Kata',
      ['MDHfjXTLveS', 'P0KYRB8l5tH'],
      DateTime.parse('2021-08-05T00:00:00.000Z'),
      DateTime.parse('2021-08-08T15:03:16.110Z'),
      0,
      links);
}

Video ryoKiyuna2020() {
  final links = [
    VideoLink('_vHRaj783Uc', VideoLinkType.youtube),
  ];

  return Video(
      'KJQ2Kj3VW55',
      'Olympic Games 2020',
      'D. Quintero vs R. Kiyuna',
      'Final Male Kata',
      ['vWlMQ4Wn5mD', 'rB3v9SVshQX'],
      DateTime.parse('2021-08-06T00:00:00.000Z'),
      DateTime.parse('2021-08-08T15:03:16.110Z'),
      0,
      links);
}

List<Video> allVideos() {
  return [sandraTokyo2020(), ryoKiyuna2020()];
}
