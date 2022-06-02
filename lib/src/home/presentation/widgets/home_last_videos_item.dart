import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/ads/interstitial_ad.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/RoundedCard.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/home/presentation/utils.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';
import 'package:karate_stars_app/src/videos/presentation/pages/video_player_page.dart';
import 'package:karate_stars_app/src/videos/presentation/widgets/item_video.dart';

class ItemHomeLastVideo extends StatefulWidget {
  final List<Video> lastVideos;
  final VoidCallback? onTapShowAll;

  const ItemHomeLastVideo({required this.lastVideos, this.onTapShowAll});

  @override
  State<ItemHomeLastVideo> createState() => _ItemHomeLastVideoState();
}

class _ItemHomeLastVideoState extends State<ItemHomeLastVideo> {
  late PlayVideoInterstitialAd _playVideoInterstitialAd;

  @override
  void initState() {
    super.initState();
    _playVideoInterstitialAd = PlayVideoInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(20.0);

    final videos = widget.lastVideos.map((video) {
      final index = widget.lastVideos.indexOf(video);
      return Column(children: [
        ItemVideo(
            video: video,
            onTap: () async {
              _playVideoInterstitialAd.show();
              VideoPlayerPage.navigate(context,
                  arguments: VideoPlayerPageArgs(videoId: video.id));
            }),
        if (index < widget.lastVideos.length - 1)
          const Divider()
        else
          Container()
      ]);
    }).toList();

    return RoundedCard(
        elevation: 0.0,
        margin: calculateMargin(context),
        borderRadius: const BorderRadius.all(radius),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ListTile(
              title: Text(
            Strings.home_last_videos_item_title,
            style: Theme.of(context).textTheme.titleMedium,
          )),
          ...videos,
          Center(
            child: TextButton(
                child: Text(
                  Strings.home_see_all,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.red),
                ),
                onPressed: widget.onTapShowAll),
          )
        ]));
  }

  @override
  void dispose() {
    super.dispose();
    _playVideoInterstitialAd.dispose();
  }
}
