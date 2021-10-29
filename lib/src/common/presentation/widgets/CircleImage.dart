import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final BorderRadius? borderRadius;
  final String imageUrl;
  final double? width;
  final double? height;
  final String? heroTag;
  final BoxFit? fit;
  final double elevation;

  static const Color _defaultShadowColor = Color(0xFF000000);

  const CircleImage(
      {this.borderRadius,
      required this.imageUrl,
      this.width,
      this.height,
      this.heroTag,
      this.fit,
      this.elevation = 0.0});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      shadowColor: _defaultShadowColor,
      borderRadius: borderRadius,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: heroTag != null && heroTag!.isNotEmpty
            ? Hero(
                tag: heroTag!,
                child: CachedNetworkImage(
                  width: width,
                  height: height,
                  imageUrl: imageUrl,
                  fit: fit ?? BoxFit.cover,
                ))
            : CachedNetworkImage(
                width: width,
                height: height,
                imageUrl: imageUrl,
                fit: fit ?? BoxFit.fill,
              ),
      ),
    );

    /* return Container(
      margin: margin,
      decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 50.0,
                offset: Offset(0.0, 0.95)
            )
          ],
         // color: Theme.of(context).colorScheme.primary
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: heroTag != null && heroTag!.isNotEmpty
            ? Hero(
                tag: heroTag!,
                child: CachedNetworkImage(
                  width: width,
                  height: height,
                  imageUrl: imageUrl,
                  fit: fit ?? BoxFit.fill,
                ))
            : CachedNetworkImage(
                width: width,
                height: height,
                imageUrl: imageUrl,
                fit: fit ?? BoxFit.fill,
              ),
      ),
    );*/
  }
}
