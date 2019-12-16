import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/twitter_icon.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/videos/widgets/item_video_player.dart';

class ItemSocialNews extends StatelessWidget {
  final SocialNews socialNews;

  const ItemSocialNews(this.socialNews);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: calculateMargin(context),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
        child: Column(children: <Widget>[
          ListTile(
            leading: CircleAvatar(
                backgroundImage: NetworkImage(socialNews.user.image)),
            title: Text(socialNews.user.name),
            trailing: Text(
              '@${socialNews.user.userName}',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          mediaWidget(),
          const SizedBox(height: 16),
          ListTile(title: Text(socialNews.summary.title)),
          ListTile(
            leading: TwitterIcon(),
            trailing: Text(
              socialNews.summary.pubDate.antiquity,
              style: Theme.of(context).textTheme.caption,
            ),
          )
        ]));
  }

  EdgeInsets calculateMargin(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    const fixed= 4.0;
    final bigMargin = mediaQueryData.size.width * 0.20;
    final smallMargin = mediaQueryData.size.width * 0.10;

    if (mediaQueryData.orientation == Orientation.portrait){
      if (mediaQueryData.size.width > 600) {
        return EdgeInsets.symmetric(vertical: fixed, horizontal: smallMargin);
      } else {
        return const EdgeInsets.symmetric(vertical: fixed, horizontal: 12.0);
      }
    } else {
      if (mediaQueryData.size.width > 600) {
        return EdgeInsets.symmetric(vertical: fixed, horizontal: bigMargin);
      } else {
        return const EdgeInsets.symmetric(vertical: fixed, horizontal: 20.0);
      }
    }
  }

  Widget mediaWidget() {
    if (socialNews.summary.video != null && socialNews.summary.video.isNotEmpty){
      return ItemVideoPlayer(videoUrl: socialNews.summary.video);
    } else if (socialNews.summary.image != null && socialNews.summary.image.isNotEmpty){
      return Image.network(socialNews.summary.image);
    } else {
      return Container();
    }
  }
}
