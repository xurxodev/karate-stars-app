import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/functions/url.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/RoundedCard.dart';
import 'package:karate_stars_app/src/events/domain/entities/event.dart';

class ItemEvent extends StatelessWidget {
  final Event event;

  const ItemEvent({required this.event});

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(20.0);

    return RoundedCard(
        elevation: 0.0,
        borderRadius: const BorderRadius.all(radius),
        child: GestureDetector(
            onTap: () {
              if (event.url != null) {
                launchURL(context, event.url!);
              }
            },
            child: ListTile(
              title: Text(event.name),
              subtitle: Text(
                  '${event.startDate.toString().substring(0,10)} / ${event.endDate.toString().substring(0,10)}'),
              trailing: const Icon(CupertinoIcons.chevron_forward)
            ,
            )));
  }
}
