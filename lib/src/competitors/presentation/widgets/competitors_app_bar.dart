import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/functions/showPlatformDialog.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/actions/FilterAction.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_alert_dialog.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/competitors/presentation/blocs/competitors_bloc.dart';
import 'package:karate_stars_app/src/competitors/presentation/widgets/competitor_filters.dart';

class CompetitorsAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final CompetitorsBloc bloc = BlocProvider.of<CompetitorsBloc>(context);

    return AppBar(
        centerTitle: false,
        title: Text(Strings.home_appbar_title_competitors,
            key: const Key(Keys.home_appbar_title),
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline6!.fontSize)),
        actions: [
          FilterAction(
            key: const Key(Keys.competitor_filter_action),
            tooltip: Strings.competitor_filters_title,
            onPressed: () {
              showPlatformDialog(
                  context: context,
                  builder: (_) => PlatformAlertDialog(
                      title: Strings.competitor_filters_title,
                      content: CompetitorFilters(bloc: bloc)));
            },
          ),
        ]);
  }
}
