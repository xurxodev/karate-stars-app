import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/presentation/functions/url.dart'
    as url_helper;
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_news.dart';

class ItemCurrentNews extends ItemNews {
  final CurrentNews currentNews;
  final String itemTextKey;

  ItemCurrentNews(this.currentNews, {required this.itemTextKey})
      : super(key: Key(itemTextKey));

  @override
  Widget buildContent(BuildContext context) {
    return GestureDetector(
        onTap: () => url_helper.launchURL(context, currentNews.summary.link),
        child: Column(children: <Widget>[
          ListTile(
            leading: _avatar(),
            title: Text(currentNews.source.name,
                key: Key('${itemTextKey}_${Keys.news_item_source}')),
          ),
          _image(),
          const SizedBox(height: 16),
          ListTile(
              title: Text(
            currentNews.summary.title,
            key: Key('${itemTextKey}_${Keys.news_item_title}'),
          )),
          ListTile(
            trailing: Text(
              currentNews.summary.pubDate.antiquity,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ]));
  }

  Widget _image() {
    if (currentNews.summary.image != null && currentNews.summary.image!.isNotEmpty) {
      return CachedNetworkImage(imageUrl: currentNews.summary.image!);
    } else {
      return Container();
    }
  }

  Widget _avatar() {
    if (currentNews.source.image.isNotEmpty) {
      return CircleAvatar(
          backgroundImage:
              CachedNetworkImageProvider(currentNews.source.image));
    } else {
      return const CircleAvatar(backgroundColor: Colors.grey);
    }
  }
}
