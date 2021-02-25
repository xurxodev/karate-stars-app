import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final BorderRadius borderRadius;
  final String imageUrl;
  final double width;
  final double height;

  const CircleImage(
      {this.borderRadius, this.imageUrl, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: imageUrl,
        fit: BoxFit.fill,
      ),
    );
  }
}
