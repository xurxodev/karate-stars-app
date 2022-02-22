import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/keys.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/functions/showPlatformDialog.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/actions/FilterAction.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_alert_dialog.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/videos/presentation/blocs/videos_bloc.dart';
import 'package:karate_stars_app/src/videos/presentation/states/videos_state.dart';
import 'package:karate_stars_app/src/videos/presentation/widgets/videos_filters.dart';

class VideosAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final VideosBloc bloc = BlocProvider.of<VideosBloc>(context);

    return AppBar(
        centerTitle: false,
        title: Text(Strings.home_appbar_title_videos,
            key: const Key(Keys.home_appbar_title),
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline6!.fontSize)),
        actions: [
          StreamBuilder<VideosState>(
            initialData: bloc.state,
            stream: bloc.observableState,
            builder: (context, snapshot) {
              final state = snapshot.data;

              return FilterAction(
                key: const Key(Keys.video_filter_action),
                tooltip: Strings.videos_filters_title,
                applied: state != null && state.filters.anyFilter,
                onPressed: () {
                  showPlatformDialog(
                      context: context,
                      builder: (_) => PlatformAlertDialog(
                          title: Strings.videos_filters_title,
                          content: VideosFilters(bloc: bloc)));
                },
              );
            },
          )
        ]);
  }
}
