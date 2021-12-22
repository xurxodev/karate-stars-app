import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/common/custom_colors.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/Progress.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/notification_message.dart';
import 'package:karate_stars_app/src/competitors/presentation/pages/competitor_detail_page.dart';
import 'package:karate_stars_app/src/home/presentation/pages/home_page.dart';
import 'package:karate_stars_app/src/search/presentation/page/search_page.dart';
import 'package:karate_stars_app/src/settings/presentation/blocs/settings_bloc.dart';
import 'package:karate_stars_app/src/settings/presentation/page/settings_page.dart';
import 'package:karate_stars_app/src/settings/presentation/states/settings_state.dart';
import 'package:karate_stars_app/src/videos/presentation/pages/competitor_videos_page.dart';
import 'package:karate_stars_app/src/videos/presentation/pages/video_player_page.dart';
import 'package:overlay_support/overlay_support.dart';

extension ThemeModeExtension on ThemeMode {
  String get name => describeEnum(this);
}

class App extends StatelessWidget {
  static const String title = 'Karate Stars';
  final bool testing;

  const App({required this.testing});

  static Widget create({required bool testing}) {
    return BlocProvider(
        bloc: app_di.getIt<SettingsBloc>(),
        child: OverlaySupport.global(child: App(testing: testing)));
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SettingsBloc>(context);

    return StreamBuilder<SettingsState>(
      initialData: bloc.state,
      stream: bloc.observableState,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state != null) {
          if (state is LoadingState) {
            return Progress();
          } else if (state is ErrorState) {
            final listState = state as ErrorState;
            return Center(
              child: NotificationMessage(listState.message),
            );
          } else {
            return _renderApp(
                context, (state as LoadedState<SettingsStateData>).data, bloc);
          }
        } else {
          return const Text('No Data');
        }
      },
    );
  }

  Widget _renderApp(
      BuildContext context, SettingsStateData data, SettingsBloc bloc) {
    return MaterialApp(
        title: title,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: whiteMaterial)
              .copyWith(secondary: Colors.red),
          scaffoldBackgroundColor: Colors.grey[300],
        ),
        darkTheme: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark()
                .copyWith(primary: Colors.grey, secondary: Colors.red)),
        themeMode: ThemeMode.values.firstWhere(
            (element) => element.name == data.selectedBrightnessOption.id),
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage.create(testing),
          SettingsPage.routeName: (context) => SettingsPage(),
          SearchPage.routeName: (context) => SearchPage.create(),
          VideoPlayerPage.routeName: (context) => VideoPlayerPage.create(
              ModalRoute.of(context)!.settings.arguments as String),
          CompetitorDetailPage.routeName: (context) =>
              CompetitorDetailPage.create(ModalRoute.of(context)!
                  .settings
                  .arguments as CompetitorDetailArgs),
          CompetitorVideosPage.routeName: (context) =>
              CompetitorVideosPage.create(ModalRoute.of(context)!
                  .settings
                  .arguments as CompetitorVideosArgs)
        });
  }
}
