import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/presentation/functions/url.dart'
    as url_helper;
import 'package:karate_stars_app/src/common/presentation/widgets/facebook_icon.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/instagram_icon.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/twitter_icon.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_news.dart';
import 'package:karate_stars_app/src/videos/presentation/widgets/video_player.dart';

class ItemSocialNews extends ItemNews {
  final SocialNews socialNews;
  final String itemTextKey;

  ItemSocialNews(this.socialNews, {required this.itemTextKey})
      : super(key: Key(itemTextKey));

  @override
  Widget buildContent(BuildContext context) {
    final linkStyle = TextStyle(
      color: Theme.of(context).colorScheme.secondary,
    );

    return Column(children: <Widget>[
      GestureDetector(
        onTap: () => url_helper.launchURL(context,
            getNetworkUrl(socialNews.network, '@${socialNews.user.userName}')),
        child: ListTile(
          leading: _avatar(context),
          title: Text(socialNews.user.name,
              key: Key('${itemTextKey}_${Keys.news_item_source}'),
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: Colors.black)),
          trailing: Text(
            '@${socialNews.user.userName}',
            key: Key('${itemTextKey}_${Keys.news_item_social_username}'),
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ),
      _mediaWidget(context),
      const SizedBox(height: 16),
      GestureDetector(
          onTap: () {
            if (socialNews.summary.link != null) {
              url_helper.launchURL(context, socialNews.summary.link!);
            }
          },
          child: ListTile(
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
                    context, getNetworkUrl(socialNews.network, hashtag)),
              ),
              MatchText(
                pattern: '@[A-Za-z0-9]*',
                style: linkStyle,
                onTap: (user) => url_helper.launchURL(
                    context, getNetworkUrl(socialNews.network, user)),
              ),
            ],
          ))),
      ListTile(
        leading: getSocialIcon(socialNews.network),
        trailing: Text(
          socialNews.summary.pubDate.antiquity,
          style: Theme.of(context).textTheme.caption,
        ),
      )
    ]);
  }

  Widget getSocialIcon(Network network) {
    final key = Key('${itemTextKey}_${Keys.news_item_social_badge}');

    final networkIcon = {
      Network.facebook: FacebookIcon(),
      Network.twitter: TwitterIcon(key: key),
      Network.instagram: InstagramIcon(),
    };

    return networkIcon[network]!;
  }

  String getNetworkUrl(Network network, String text) {
    final networkUrl = {
      Network.facebook: url_helper.createFacebookURL(text),
      Network.twitter: url_helper.createTwitterURL(text),
      Network.instagram: url_helper.createInstagramURL(text),
    };

    return networkUrl[network]!;
  }

  Widget _mediaWidget(BuildContext context) {
    if (socialNews.summary.video != null &&
        socialNews.summary.video!.isNotEmpty) {
      return VideoPlayer(videoUrl: socialNews.summary.video!);
    } else if (socialNews.summary.image != null &&
        socialNews.summary.image!.isNotEmpty) {
      return GestureDetector(
          onTap: () {
            if (socialNews.summary.link != null) {
              url_helper.launchURL(context, socialNews.summary.link!);
            }
          },
          child: CachedNetworkImage(imageUrl: socialNews.summary.image!));
    } else {
      return Container();
    }
  }

  Widget _avatar(BuildContext context) {
    if (socialNews.user.image.isNotEmpty) {
      return CircleAvatar(
          radius: 18,
          backgroundImage: CachedNetworkImageProvider(socialNews.user.image));
    } else {
      return const CircleAvatar(backgroundColor: Colors.grey);
    }
  }
}
