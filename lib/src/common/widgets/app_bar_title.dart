import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Image.asset(
          "assets/images/logo.png",
          width: 40,
        ),
        new SizedBox(
          width: 8.0,
        ),
        Text(
          'Karate Stars',
          style: TextStyle(
            fontFamily: 'Billabong',
            fontSize: 35.0,
          ),
        )
      ],
    );
  }
}
