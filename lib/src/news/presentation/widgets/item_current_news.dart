import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_news.dart';

class ItemCurrentNews extends ItemNews {
  final CurrentNews currentNews;

  const ItemCurrentNews(this.currentNews);

  @override
  Widget buildContent(BuildContext context) {
    return Column(children: <Widget>[
      ListTile(
        leading: CircleAvatar(
            backgroundImage: NetworkImage(currentNews.source.image)),

/*        leading: SizedBox(
          width: 50,
            child: Image.network(
          currentNews.source.image,
          fit: BoxFit.scaleDown,
        )),*/
        title: Text(currentNews.source.name),
      ),
      Image.network(currentNews.summary.image),
      const SizedBox(height: 16),
      ListTile(title: Text(currentNews.summary.title)),
      ListTile(
        trailing: Text(
          currentNews.summary.pubDate.antiquity,
          style: Theme.of(context).textTheme.caption,
        ),
      ),
    ]);
  }
}
