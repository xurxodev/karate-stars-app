import 'package:karate_stars_app/src/videos/domain/entities/video.dart';

class VideoParser {
  List<Video> parse(List<dynamic> json) {
    return json.map((jsonItem) => _parseCompetitor(jsonItem)).toList();
  }

  Video _parseCompetitor(Map<String, dynamic> jsonData) {
    final links = (jsonData['links'] as List<dynamic>).map((link) {
      return parseLink(link);
    }).toList();

    return Video(
        jsonData['id'],
        jsonData['title'],
        jsonData['subtitle'],
        jsonData['description'],
        (jsonData['competitors'] as List<dynamic>).cast<String>(),
        DateTime.parse(jsonData['eventDate']),
        DateTime.parse(jsonData['createdDate']),
        jsonData['order'],
        jsonData['isLive'],
        links);
  }

  VideoLink parseLink(Map<String, dynamic> json) {
    final videoLinkType = VideoLinkType.values
        .firstWhere((e) => e.toString().contains(json['type']));

    return VideoLink(json['id'], videoLinkType);
  }
}
