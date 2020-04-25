import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';

class ItemCompetitor extends StatelessWidget {
  final Competitor competitor;
  final String itemTextKey;

  ItemCompetitor(this.competitor, {this.itemTextKey})
      : super(key: Key(itemTextKey));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        //onTap: () => url_helper.launchURL(context, currentNews.summary.link),

        //Try card??????? but create custom card componet and use it in all list
        child: Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(Radius.circular(20.0))),
      child: Column(
        children: <Widget>[
          ListTile(title: Text(competitor.name)),
          CachedNetworkImage(imageUrl: competitor.mainImage),
          ListTile(
            leading: const Text('Spain'),
            trailing: CachedNetworkImage(
              height: 25,
              imageUrl: 'http://www.karatestarsapp.com/app/flags/es.png',
            ),
          ),
/*          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child:
            CachedNetworkImage(imageUrl: competitor.mainImage),
          ),*/
          //key: Key('${itemTextKey}_${Keys.news_item_source}'))),
        ],
      ),
    ));
  }
}
