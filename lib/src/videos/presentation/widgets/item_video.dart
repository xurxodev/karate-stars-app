import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/RoundedCard.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';

class ItemVideo extends StatelessWidget {
  final Video video;
  final GestureTapCallback? onTap;
  final Color? color;

  const ItemVideo({required this.video, this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(20.0);

    return RoundedCard(
        color: color,
        elevation: 0.0,
        borderRadius: const BorderRadius.all(radius),
        child: GestureDetector(
          onTap: onTap,
          child: ListTile(
            title: Text(video.title),
            subtitle: Text('${video.subtitle} \n${video.description}'),
            isThreeLine: true,
            trailing: Container(
              height: double.infinity,
              child: Icon(
                Icons.play_arrow,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ));
  }
}
