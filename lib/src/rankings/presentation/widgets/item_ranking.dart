import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/functions/url.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/RoundedCard.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/ranking.dart';

class ItemRanking extends StatelessWidget {
  final Ranking ranking;

  const ItemRanking({required this.ranking});

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(20.0);

    return RoundedCard(
        elevation: 0.0,
        borderRadius: const BorderRadius.all(radius),
        child: GestureDetector(
            onTap: () {
              if (ranking.apiUrl == null) {
                launchURL(context, ranking.webUrl);
              }
            },
            child: ListTile(
              leading: CircleAvatar(
                 backgroundColor: Colors.transparent,
                  backgroundImage: CachedNetworkImageProvider(ranking.image)),
              title: Text(ranking.name),
              trailing: const Icon(CupertinoIcons.chevron_forward),
            )));
  }
}
