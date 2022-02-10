import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_widget.dart';
import 'package:karate_stars_app/src/common/strings.dart';

class MenuItem {
  String name;
  VoidCallback onTap;
  IconData iconData;

  MenuItem(this.name, this.iconData, this.onTap);
}

class PlatformMenu extends PlatformWidget<IconButton, PopupMenuButton> {
  final List<MenuItem> menuItems;

  PlatformMenu({required this.menuItems});

  @override
  PopupMenuButton createMaterialWidget(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (context) => menuItems.map((menuItem) {
              return PopupMenuItem(
                child: Row(children: [
                  Icon(menuItem.iconData),
                  const SizedBox(width: 16),
                  Text(menuItem.name)
                ]),
                onTap: menuItem.onTap,
              );
            }).toList());
  }

  @override
  IconButton createCupertinoWidget(BuildContext context) {
    return IconButton(
        icon: const Icon(CupertinoIcons.ellipsis_circle),
        onPressed: () {
          final act = CupertinoActionSheet(
              message: const Text(Strings.home_menu_title),
              actions: menuItems.map((menuItem) {
                return CupertinoActionSheetAction(
                  child: Row(children: [
                    const SizedBox(width: 16),
                    Icon(menuItem.iconData),
                    const SizedBox(width: 16),
                    Text(menuItem.name,
                        style: Theme.of(context).textTheme.subtitle1)
                  ]),
                  onPressed: menuItem.onTap,
                );
              }).toList()
              );
          showCupertinoModalPopup(
              context: context, builder: (BuildContext context) => act);
        });
  }
}
