import 'package:flutter/material.dart';

class MedalIcon extends StatelessWidget {
  final Color? color;
  final String text;

  const MedalIcon({Key? key, required this.color, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.0,
      height: 24.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
          child: Text(
        text,
        style:
            Theme.of(context).textTheme.caption!.copyWith(color: Colors.black),
      )),
    );
  }
}

class GoldMedalIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MedalIcon(color: Colors.yellow[600], text: '1');
  }
}

class SilverMedalIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MedalIcon(color: Colors.grey[350], text: '2');
  }
}

class BronzeMedalIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MedalIcon(color: Colors.brown[300], text: '3');
  }
}
