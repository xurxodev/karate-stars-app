import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/presentation/functions/url.dart'
    as url_helper;
import 'package:karate_stars_app/src/common/presentation/widgets/twitter_icon.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_news.dart';
import 'package:karate_stars_app/src/videos/widgets/video_player.dart';

class ItemSocialNews extends ItemNews {
  final SocialNews socialNews;
  final String itemTextKey;

  ItemSocialNews(this.socialNews, {required this.itemTextKey})
      : super(key: Key(itemTextKey));

  @override
  Widget buildContent(BuildContext context) {
    final linkStyle = TextStyle(
      color: Theme.of(context).accentColor,
    );

    return Column(children: <Widget>[
      GestureDetector(
        onTap: () => url_helper.launchURL(context,
            url_helper.createTwitterURL('@${socialNews.user.userName}')),
        child: ListTile(
          leading: _avatar(),
          title: Text(socialNews.user.name,
              key: Key('${itemTextKey}_${Keys.news_item_source}')),
          trailing: Text(
            '@${socialNews.user.userName}',
            key: Key('${itemTextKey}_${Keys.news_item_social_username}'),
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ),
      _mediaWidget(),
      const SizedBox(height: 16),
      ListTile(
          title: ParsedText(
        key: Key('${itemTextKey}_${Keys.news_item_title}'),
        text: socialNews.summary.title,
        style: Theme.of(context).textTheme.subtitle1,
        parse: <MatchText>[
          MatchText(
            type: ParsedType.URL,
            style: linkStyle,
            onTap: (url) => url_helper.launchURL(context, url),
          ),
          MatchText(
            pattern: r'(^|\s)#(\w*[a-zA-Z_]+\S*)',
            style: linkStyle,
            onTap: (hashtag) => url_helper.launchURL(
                context, url_helper.createTwitterURL(hashtag)),
          ),
          MatchText(
            pattern: '@[A-Za-z0-9]*',
            style: linkStyle,
            onTap: (user) =>
                url_helper.launchURL(context, url_helper.createTwitterURL(user)),
          ),
        ],
      )),
      ListTile(
        leading: TwitterIcon(
            key: Key('${itemTextKey}_${Keys.news_item_social_badge}')),
        trailing: Text(
          socialNews.summary.pubDate.antiquity,
          style: Theme.of(context).textTheme.caption,
        ),
      )
    ]);
  }

  Widget _mediaWidget() {
    if (socialNews.summary.video != null &&
        socialNews.summary.video!.isNotEmpty) {
      return VideoPlayer(videoUrl: socialNews.summary.video!);
    } else if (socialNews.summary.image != null &&
        socialNews.summary.image!.isNotEmpty) {
      return CachedNetworkImage(imageUrl: socialNews.summary.image!);
    } else {
      return Container();
    }
  }

  Widget _avatar() {
    if (socialNews.user.image.isNotEmpty) {
      return CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(socialNews.user.image));
    } else {
      return const CircleAvatar(backgroundColor: Colors.grey);
    }
  }
}
