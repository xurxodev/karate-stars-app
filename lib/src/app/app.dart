import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/app/app_bloc.dart';
import 'package:karate_stars_app/src/app/app_state.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/default_stream_builder.dart';
import 'package:karate_stars_app/src/global_di.dart' as app_di;
import 'package:karate_stars_app/src/common/custom_colors.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/Progress.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/notification_message.dart';
import 'package:karate_stars_app/src/competitors/presentation/pages/competitor_detail_page.dart';
import 'package:karate_stars_app/src/events/presentation/pages/events_page.dart';
import 'package:karate_stars_app/src/main/main_page.dart';
import 'package:karate_stars_app/src/news/presentation/page/current_news_page.dart';
import 'package:karate_stars_app/src/purchases/presentation/page/purchases_page.dart';
import 'package:karate_stars_app/src/rankings/presentation/pages/rankings_categories_page.dart';
import 'package:karate_stars_app/src/rankings/presentation/pages/rankings_entries_page.dart';
import 'package:karate_stars_app/src/rankings/presentation/pages/rankings_page.dart';
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
        bloc: app_di.getIt<AppBloc>(),
        child: BlocProvider(
            bloc: app_di.getIt<SettingsBloc>(),
            child: OverlaySupport.global(child: App(testing: testing))));
  }

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);

    return DefaultStateStreamBuilder<SettingsStateData>(
        initialData: settingsBloc.state,
        stream: settingsBloc.observableState,
        builder: (context, snapshot) {
          final settingsState =
              (snapshot.data as LoadedState<SettingsStateData>).data;

          return _renderApp(
              context, settingsState, settingsBloc);
        });
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
            (element) => element.name == data.selectedBrightnessOption),
        initialRoute: MainPage.routeName,
        routes: {
          MainPage.routeName: (context) => MainPage.create(testing),
          PurchasesPage.routeName: (context) => PurchasesPage.create(),
          SettingsPage.routeName: (context) => SettingsPage(),
          SearchPage.routeName: (context) => SearchPage.create(),
          VideoPlayerPage.routeName: (context) => VideoPlayerPage.create(
              ModalRoute.of(context)!.settings.arguments
                  as VideoPlayerPageArgs),
          CompetitorDetailPage.routeName: (context) =>
              CompetitorDetailPage.create(ModalRoute.of(context)!
                  .settings
                  .arguments as CompetitorDetailArgs),
          CompetitorVideosPage.routeName: (context) =>
              CompetitorVideosPage.create(ModalRoute.of(context)!
                  .settings
                  .arguments as CompetitorVideosArgs),
          EventsPage.routeName: (context) => EventsPage.create(),
          CurrentNewsPage.routeName: (context) => CurrentNewsPage.create(),
          RankingsPage.routeName: (context) => RankingsPage.create(),
          RankingCategoriesPage.routeName: (context) =>
              RankingCategoriesPage.create(ModalRoute.of(context)!
                  .settings
                  .arguments as RankingCategoriesArgs),
          RankingEntriesPage.routeName: (context) => RankingEntriesPage.create(
              ModalRoute.of(context)!.settings.arguments as RankingEntriesArgs),
        });
  }
}
