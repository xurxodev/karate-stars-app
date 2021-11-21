import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

void showLocalNotification(BuildContext context, RemoteMessage message,
    {GestureTapCallback? onTap}) {
  showSimpleNotification(
    GestureDetector(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            width: double.infinity,
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(message.notification!.title!,
                      style: Theme.of(context).textTheme.bodyText1),
                ),
                Text(message.notification!.body!,
                    style: Theme.of(context).textTheme.bodyText2)
              ],
            ))),
    leading: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Image.asset('assets/images/logo.png')),
    duration: const Duration(milliseconds: 5000),
    background: Theme.of(context).cardColor,
    slideDismissDirection: DismissDirection.up
  );
}
