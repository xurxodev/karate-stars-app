import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_widget.dart';
import 'package:karate_stars_app/src/common/strings.dart';

class SearchAppBar extends PlatformWidget
    implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);

  final _controller = TextEditingController();

  final ValueChanged<String>? onChanged;
  final VoidCallback? onCancel;

  SearchAppBar({this.onChanged, this.onCancel});

  @override
  Widget createMaterialWidget(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: BackButton(onPressed: onCancel),
      title: TextField(
        controller: _controller,
        decoration: const InputDecoration.collapsed(
            hintText: Strings.search_app_bar_hint),
        onChanged: onChanged,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _controller.clear();

            if (onChanged != null){
              onChanged!('');
            }
          },
        ),
      ],
    );
  }

  @override
  Widget createCupertinoWidget(BuildContext context) {

    return AppBar(
      automaticallyImplyLeading: false,
      title: CupertinoSearchTextField(
        style: Theme.of(context).textTheme.bodyText2,
        placeholder: Strings.search_app_bar_hint,
        onChanged: onChanged,
      ),
      actions: [
        CupertinoButton(
          child: Text('Cancel',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: 18)),
          //padding: const EdgeInsets.symmetric(horizontal: 8.0),
          onPressed: onCancel,
        )
      ],
    );
  }
}
