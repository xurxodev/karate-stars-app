import 'package:flutter/foundation.dart';
import 'package:karate_stars_app/src/common/data/local/DataBaseMapper.dart';
import 'package:karate_stars_app/src/videos/data/local/models/video_db.dart';
import 'package:karate_stars_app/src/videos/data/local/models/video_link_db.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';

class VideoMapper implements DataBaseMapper<Video, VideoDB> {
  @override
  Video mapToDomain(VideoDB modelDB) {
    final videoLinks = modelDB.links.map((videoLinkDB) {
      final VideoLinkType videoLinkType = VideoLinkType.values.firstWhere(
          (e) => e.toString().toLowerCase().contains(videoLinkDB.type));

      return VideoLink(videoLinkDB.id, videoLinkType);
    }).toList();

    return Video(
        modelDB.id,
        modelDB.title,
        modelDB.subtitle,
        modelDB.description,
        modelDB.competitors,
        modelDB.eventDate,
        modelDB.createdDate,
        modelDB.order,
        modelDB.isLive,
        videoLinks);
  }

  @override
  VideoDB mapToDB(Video entity) {
    final videoLinksDB = entity.links.map((videoLink) {
      return VideoLinkDB(videoLink.id, describeEnum(videoLink.type));
    }).toList();

    return VideoDB(
      entity.id,
      entity.title,
      entity.subtitle,
      entity.description,
      entity.competitors,
      entity.eventDate,
      entity.createdDate,
      entity.order,
      entity.isLive,
      videoLinksDB,
      DateTime.now().toIso8601String(),
    );
  }
}
