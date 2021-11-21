import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/news/domain/entities/live_video_news.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_news.dart';
import 'package:karate_stars_app/src/videos/presentation/pages/video_player_page.dart';

class ItemLiveVideoNews extends ItemNews {
  final LiveVideoNews liveVideoNews;

  const ItemLiveVideoNews({required this.liveVideoNews})
      : super();

  @override
  Widget buildContent(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, VideoPlayerPage.routeName,
            arguments: liveVideoNews.firstVideoId);
      },
      child: ListTile(
        title: Text(liveVideoNews.summary.title),
        trailing: const Icon(CupertinoIcons.chevron_forward),
      ),
    );
  }
}
