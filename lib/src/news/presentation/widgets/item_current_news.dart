import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/browser/presentation/pages/browser_page.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_news.dart';

class ItemCurrentNews extends ItemNews {
  final CurrentNews currentNews;

  const ItemCurrentNews(this.currentNews);
  

  @override
  Widget buildContent(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.pushNamed(context, BrowserPage.routeName,
            arguments: currentNews.summary.link),
        child: Column(children: <Widget>[
          ListTile(
            leading: CircleAvatar(
                backgroundImage: NetworkImage(currentNews.source.image)),
            title: Text(currentNews.source.name),
          ),
          CachedNetworkImage(imageUrl: currentNews.summary.image),
          const SizedBox(height: 16),
          ListTile(title: Text(currentNews.summary.title)),
          ListTile(
            trailing: Text(
              currentNews.summary.pubDate.antiquity,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        ]));
  }
}
