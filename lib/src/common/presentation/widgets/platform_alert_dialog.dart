import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/strings.dart';

class PlatformAlertDialog extends StatelessWidget {
  final String title;
  final Widget content;

  const PlatformAlertDialog({this.title, this.content});

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return _cupertinoAlertDialog(context);
    } else {
      return _materialAlertDialog(context);
    }
  }

  Widget _materialAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Padding(
          padding: const EdgeInsets.only(bottom: 16.0), child: Text(title)),
      content: content,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      actions: <Widget>[
        FlatButton(
          child: Text(
            Strings.ok,
            key: const Key(Keys.alert_dialog_ok_button),
            style:
                Theme.of(context).textTheme.button.copyWith(color: Colors.red),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  Widget _cupertinoAlertDialog(BuildContext context) {
    return CupertinoAlertDialog(
        title: Padding(
            padding: const EdgeInsets.only(bottom: 16.0), child: Text(title)),
        content: content,
        actions: [
          CupertinoDialogAction(
              key: const Key(Keys.alert_dialog_ok_button),
              isDefaultAction: true,
              child: Text(
                Strings.ok,
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ]);
  }
}
