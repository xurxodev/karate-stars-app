import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            'OK',
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
              isDefaultAction: true,
              child: Text(
                'OK',
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
