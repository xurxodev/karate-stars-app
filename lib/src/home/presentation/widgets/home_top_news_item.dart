import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/RoundedCard.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/home/presentation/utils.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/presentation/widgets/item_current_news.dart';

class ItemHomeTopNews extends StatelessWidget {
  final List<CurrentNews> topNews;
  final VoidCallback? onTapShowAll;

  const ItemHomeTopNews({required this.topNews, this.onTapShowAll});

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(20.0);

    final news = topNews.map((newsItem) {
      final index = topNews.indexOf(newsItem);

      final textKey = '${Keys.news_item}_$index';

      return Column(children: [
        ItemCurrentNews(
            currentNews: newsItem,
            itemTextKey: textKey,
            type: index == 0 ? CurrentNewsType.big : CurrentNewsType.small),
        if (index < topNews.length - 1) const Divider() else Container()
      ]);
    }).toList();

    return RoundedCard(
        elevation: 0.0,
        margin: calculateMargin(context),
        borderRadius: const BorderRadius.all(radius),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ListTile(
              title: Text(
            Strings.top_news,
            style: Theme.of(context).textTheme.titleMedium,
          )),
          ...news,
          Center(
            child: TextButton(
                child: Text(
                  Strings.home_see_all,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.red),
                ),
                onPressed: onTapShowAll),
          )
        ]));
  }
}
