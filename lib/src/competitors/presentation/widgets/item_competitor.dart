import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/CircleImage.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/RoundedCard.dart';
import 'package:karate_stars_app/src/competitors/presentation/pages/competitor_detail_page.dart';
import 'package:karate_stars_app/src/competitors/presentation/states/competitors_state.dart';

class ItemCompetitor extends StatelessWidget {
  final CompetitorItemState competitor;
  final String itemTextKey;
  final EdgeInsetsGeometry? margin;

  ItemCompetitor(this.competitor, {required this.itemTextKey, this.margin})
      : super(key: Key(itemTextKey));

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(20.0);

    return RoundedCard(
      elevation: 0.0,
      margin: margin ?? EdgeInsets.zero,
      borderRadius: const BorderRadius.all(radius),
      child: GestureDetector(
          onTap: () async {
            Navigator.pushNamed(context, CompetitorDetailPage.routeName,
                arguments: CompetitorDetailArgs(
                    competitorId: competitor.id, imageUrl: competitor.image));
          },
          child: Column(
            children: <Widget>[
              CircleImage(
                  //height: 250,
                  heroTag: competitor.id,
                  borderRadius: const BorderRadius.only(
                      topLeft: radius, topRight: radius),
                  width: double.infinity,
                  imageUrl: competitor.image),
              ListTile(
                title: Text(competitor.name),
                trailing: CircleImage(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    height: 20,
                    width: 30,
                    imageUrl: competitor.flag),
              )
            ],
          )),
    );
  }
}
