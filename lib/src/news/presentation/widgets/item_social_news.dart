import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/twitter_icon.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';

class ItemSocialNews extends StatelessWidget {
  final SocialNews socialNews;

  const ItemSocialNews(this.socialNews);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
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
          Image.network(socialNews.summary.image),
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
}
