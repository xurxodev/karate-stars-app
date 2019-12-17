
import 'package:flutter/material.dart';

abstract class ItemNews extends StatelessWidget {
  const ItemNews({ Key key }) : super(key: key);

  @override
  @protected
  Widget build(BuildContext context){
    return Container(
        margin: calculateMargin(context),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(20.0))),
        child: buildContent(context));
  }


  @protected
  EdgeInsets calculateMargin(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    const fixed= 4.0;
    final bigMargin = mediaQueryData.size.width * 0.20;
    final smallMargin = mediaQueryData.size.width * 0.10;

    if (mediaQueryData.orientation == Orientation.portrait){
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