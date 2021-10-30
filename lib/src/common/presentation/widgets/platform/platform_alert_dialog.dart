import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_widget.dart';
import 'package:karate_stars_app/src/common/strings.dart';

class PlatformAlertDialog
    extends PlatformWidget<CupertinoAlertDialog, AlertDialog> {
  final String title;
  final Widget content;

  PlatformAlertDialog({required this.title, required this.content});

  @override
  AlertDialog createMaterialWidget(BuildContext context) {
    print('AlertDialog');
    return AlertDialog(
      key: const Key(Keys.alert_dialog),
      title: Padding(
          padding: const EdgeInsets.only(bottom: 16.0), child: Text(title)),
      content: content,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      actions: <Widget>[
        TextButton(
          child: Text(
            Strings.ok,
            key: const Key(Keys.alert_dialog_ok_button),
            style:
                Theme.of(context).textTheme.button!.copyWith(color: Colors.red),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  @override
  CupertinoAlertDialog createCupertinoWidget(BuildContext context) {
    print('CupertinoAlertDialog');
    return CupertinoAlertDialog(
        key: const Key(Keys.alert_dialog),
        title: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(title, style: Theme.of(context).textTheme.headline6)),
        content: content,
        actions: [
          CupertinoDialogAction(
              key: const Key(Keys.alert_dialog_ok_button),
              isDefaultAction: true,
              child: Text(
                Strings.ok,
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ]);
  }
}
