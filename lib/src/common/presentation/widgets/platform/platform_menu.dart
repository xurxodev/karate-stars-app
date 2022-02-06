import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/functions/url.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_widget.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/settings/presentation/page/settings_page.dart';

class PlatformMenu extends PlatformWidget<IconButton, PopupMenuButton> {
  @override
  PopupMenuButton createMaterialWidget(BuildContext context) {
    return PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 0,
          child: Row(children: const [
            Icon(Icons.settings),
            SizedBox(width: 16),
            Text(Strings.home_menu_settings)
          ]),
          onTap: () => Navigator.pushNamed(context, SettingsPage.routeName),
        ),
        PopupMenuItem(
          value: 0,
          child: Row(children: const [
            Icon(Icons.leaderboard_outlined),
            SizedBox(width: 16),
            Text(Strings.home_menu_rankings)
          ]),
          onTap: () => launchURL(context, Strings.url_rankings),
        ),
      ],
    );
  }

  @override
  IconButton createCupertinoWidget(BuildContext context) {
    return IconButton(
        icon: const Icon(CupertinoIcons.ellipsis_circle),
        onPressed: () {
          final act = CupertinoActionSheet(
            message: const Text(Strings.home_menu_title),
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Row(children: [
                  const SizedBox(width: 16),
                  const Icon(CupertinoIcons.wrench),
                  const SizedBox(width: 16),
                  Text(Strings.home_menu_settings,
                      style: Theme.of(context).textTheme.subtitle1)
                ]),
                onPressed: () {
                  Navigator.pushNamed(context, SettingsPage.routeName);
                },
              ),
              CupertinoActionSheetAction(
                child: Row(children: [
                  const SizedBox(width: 16),
                  const Icon(Icons.leaderboard_outlined),
                  const SizedBox(width: 16),
                  Text(Strings.home_menu_rankings,
                      style: Theme.of(context).textTheme.subtitle1)
                ]),
                onPressed: () => launchURL(context, Strings.url_rankings),
              )
            ],
          );
          showCupertinoModalPopup(
              context: context, builder: (BuildContext context) => act);
        });
  }
}
