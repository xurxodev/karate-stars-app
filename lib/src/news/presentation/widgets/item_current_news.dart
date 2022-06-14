import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/presentation/functions/url.dart'
    as url_helper;
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_news.dart';

enum CurrentNewsType { big, small }

class ItemCurrentNews extends ItemNews {
  final CurrentNews currentNews;
  final String itemTextKey;
  final CurrentNewsType type;

  ItemCurrentNews(
      {required this.currentNews,
      required this.type,
      required this.itemTextKey})
      : super(key: Key(itemTextKey));

  @override
  Widget buildContent(BuildContext context) {
    return GestureDetector(
        onTap: () => url_helper.launchURL(context, currentNews.summary.link!),
        child: type == CurrentNewsType.big ? _big(context) : _small(context));
  }

  Widget _small(BuildContext context) {
    return Column(children: <Widget>[
      ListTile(
        title: Text(
          currentNews.summary.title,
          key: Key('${itemTextKey}_${Keys.news_item_title}'),
        ),
        trailing: SizedBox(
          width: 100,
          child: _image(),
        ),
      ),
      _bottom(context)
    ]);
  }

  Widget _big(BuildContext context) {
    return Column(children: <Widget>[
      _image(),
      const SizedBox(height: 16),
      ListTile(
          title: Text(
        currentNews.summary.title,
        key: Key('${itemTextKey}_${Keys.news_item_title}'),
      )),
      _bottom(context)
    ]);
  }

  Widget _bottom(BuildContext context) {
    return ListTile(
      leading: _avatar(),
      title: Text(currentNews.source.name,
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(color: Colors.black),
          key: Key('${itemTextKey}_${Keys.news_item_source}')),
      trailing: Text(
        currentNews.summary.pubDate.antiquity,
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }

  Widget _image() {
    if (currentNews.summary.image != null &&
        currentNews.summary.image!.isNotEmpty) {
      final radiusValue = type == CurrentNewsType.big ? 20.0 : 0.0;

      return ClipRRect(
        child: Container(
            width: double.infinity,
            child: CachedNetworkImage(
                imageUrl: currentNews.summary.image!, fit: BoxFit.fitWidth)),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(radiusValue),
            topRight: Radius.circular(radiusValue)),
      );
    } else {
      return Container();
    }
  }

  Widget _avatar() {
    if (currentNews.source.image.isNotEmpty) {
      return CircleAvatar(
          radius: 18,
          backgroundImage:
              CachedNetworkImageProvider(currentNews.source.image));
    } else {
      return const CircleAvatar(backgroundColor: Colors.grey);
    }
  }
}
