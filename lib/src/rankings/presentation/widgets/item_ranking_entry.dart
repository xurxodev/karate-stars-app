import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/RoundedCard.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/medals.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/rankingEntry.dart';

class ItemRankingEntry extends StatelessWidget {
  final RankingEntry rankingEntry;

  const ItemRankingEntry({required this.rankingEntry});

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(20.0);

    final positionWidget = rankingEntry.rank == 1
        ? GoldMedalIcon()
        : rankingEntry.rank == 2
            ? SilverMedalIcon()
            : rankingEntry.rank == 3
                ? BronzeMedalIcon()
                : MedalIcon(
                    color: Colors.blue[100],
                    text: rankingEntry.rank.toString());

    return RoundedCard(
        elevation: 0.0,
        borderRadius: const BorderRadius.all(radius),
        child: GestureDetector(
            onTap: () {},
            child: ListTile(
              contentPadding: const EdgeInsets.only(
                  left: 8.0, top: 0.0, right: 16.0, bottom: 0.0),
              isThreeLine: true,
              leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                  backgroundImage: CachedNetworkImageProvider(
                    rankingEntry.photo,
                  )),
              title: Flexible(
                  child: Text(rankingEntry.name,
                      style: Theme.of(context).textTheme.bodyText1)),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CachedNetworkImage(
                          width: 18,
                          imageUrl:
                              'https://setopen.sportdata.org/setglimg/world48/${rankingEntry.countryCode}.png',
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Flexible(
                            child: Text(rankingEntry.country,
                                style: Theme.of(context).textTheme.caption)),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text('Points: ${rankingEntry.totalPoints.toString()}',
                        style: Theme.of(context).textTheme.caption)
                  ]),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  positionWidget,
                ],
              ),
            )));
  }
}
