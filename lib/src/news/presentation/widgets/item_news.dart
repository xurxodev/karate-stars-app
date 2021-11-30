import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/RoundedCard.dart';

abstract class ItemNews extends StatelessWidget {
  final Color? color;
  
  const ItemNews({Key? key, this.color}) : super(key: key);

  @override
  @protected
  Widget build(BuildContext context) {
    return RoundedCard(
        color: color,
        margin: calculateMargin(context),
        elevation: 0.0,
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        child: buildContent(context));
  }

  @protected
  EdgeInsets calculateMargin(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    const fixed = 4.0;
    final bigMargin = mediaQueryData.size.width * 0.20;
    final smallMargin = mediaQueryData.size.width * 0.10;

    if (mediaQueryData.orientation == Orientation.portrait) {
      if (mediaQueryData.size.width > 600) {
        return EdgeInsets.symmetric(vertical: fixed, horizontal: smallMargin);
      } else {
        return const EdgeInsets.symmetric(vertical: fixed, horizontal: 12.0);
      }
    } else {
      if (mediaQueryData.size.width > 600) {
        return EdgeInsets.symmetric(vertical: fixed, horizontal: bigMargin);
      } else {
        return const EdgeInsets.symmetric(vertical: fixed, horizontal: 20.0);
      }
    }
  }

  @protected
  Widget buildContent(BuildContext context);


}
