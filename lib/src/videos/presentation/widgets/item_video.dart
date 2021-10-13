import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';

class ItemVideo extends StatelessWidget {
  final Video video;
  final GestureTapCallback? onTap;

  const ItemVideo({required this.video, this.onTap});

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(20.0);

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.all(radius),
        ),
        child: GestureDetector(
          onTap: onTap ,
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
