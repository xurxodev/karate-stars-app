import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/twitter_icon.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_news.dart';
import 'package:karate_stars_app/src/videos/widgets/item_video_player.dart';

class ItemSocialNews extends ItemNews {
  final SocialNews socialNews;

  const ItemSocialNews(this.socialNews);

  @override
  Widget buildContent(BuildContext context) {
    final linkStyle =  TextStyle(color: Theme.of(context).accentColor,);

    return Column(children: <Widget>[
      ListTile(
        leading:
            CircleAvatar(backgroundImage: NetworkImage(socialNews.user.image)),
        title: Text(socialNews.user.name),
        trailing: Text(
          '@${socialNews.user.userName}',
          style: Theme.of(context).textTheme.caption,
        ),
      ),
      _mediaWidget(),
      const SizedBox(height: 16),
      ListTile(
          title: ParsedText(
        text: socialNews.summary.title,
        parse: <MatchText>[
          MatchText(
            type: ParsedType.URL,
            style: linkStyle,
            onTap: (url) {
              print(url);
            },
          ),
          MatchText(
            pattern: r'(^|\s)#(\w*[a-zA-Z_]+\S*)',
            style: linkStyle,
            onTap: (hashtag) {
              print(hashtag);
            },
          ),
          MatchText(
            pattern: '@[A-Za-z0-9]*',
            style: linkStyle,
            onTap: (user) {
              print(user);
            },
          ),
        ],
      )),
      ListTile(
        leading: TwitterIcon(),
        trailing: Text(
          socialNews.summary.pubDate.antiquity,
          style: Theme.of(context).textTheme.caption,
        ),
      )
    ]);
  }

  Widget _mediaWidget() {
    if (socialNews.summary.video != null &&
        socialNews.summary.video.isNotEmpty) {
      return ItemVideoPlayer(videoUrl: socialNews.summary.video);
    } else if (socialNews.summary.image != null &&
        socialNews.summary.image.isNotEmpty) {
      return Image.network(socialNews.summary.image);
    } else {
      return Container();
    }
  }
}
