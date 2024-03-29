import 'package:app_review/app_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/ads/ad.dart';
import 'package:karate_stars_app/src/ads/ads_helper.dart';
import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/functions/url.dart';
import 'package:karate_stars_app/src/common/presentation/icons/custom_icons.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/CircleImage.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/CustomScrollViewWithFab.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/Progress.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/medals.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/notification_message.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';
import 'package:karate_stars_app/src/competitors/presentation/blocs/competitor_detail_bloc.dart';
import 'package:karate_stars_app/src/competitors/presentation/states/competitor_detail_state.dart';
import 'package:karate_stars_app/src/videos/presentation/pages/competitor_videos_page.dart';
import 'package:visibility_detector/visibility_detector.dart';

class CompetitorDetailArgs {
  final String competitorId;
  final String? imageUrl;
  final ReadPolicy readPolicy;

  CompetitorDetailArgs(
      {required this.competitorId,
      this.imageUrl,
      this.readPolicy = ReadPolicy.cache_first});
}

class CompetitorDetailPage extends StatelessWidget {
  final CompetitorDetailArgs args;
  static const routeName = '/competitor';

  const CompetitorDetailPage({required this.args});

  static void navigate(BuildContext context,
      {required CompetitorDetailArgs arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static Widget create(CompetitorDetailArgs args) {
    return BlocProvider(
        bloc: app_di.getIt<CompetitorDetailBloc>(),
        child: CompetitorDetailPage(args: args));
  }

  @override
  Widget build(BuildContext context) {
    final CompetitorDetailBloc bloc =
        BlocProvider.of<CompetitorDetailBloc>(context);
    bloc.init(competitorId: args.competitorId, readPolicy: args.readPolicy);

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        body: SafeArea(
            child: StreamBuilder<CompetitorDetailState>(
          initialData: bloc.state,
          stream: bloc.observableState,
          builder: (context, snapshot) {
            final state = snapshot.data;

            if (state != null) {
              Future.delayed(const Duration(milliseconds: 100), () async {
                if (state.requestRateApp == true){

                  final available = await AppReview.isRequestReviewAvailable;

                  if (available) {
                    print('Request review');
                    AppReview.requestReview.then((value) {
                      print('Review ok ' + value.toString());
                    });
                  }
                }
              });

              const radius = Radius.circular(60.0);
              return CustomScrollViewWithFab(
                  expandedHeight: 400,
                  floatingPosition: const FloatingPosition(right: 20.0),
                  floatingWidget: SpeedDial(
                      icon: Icons.navigate_next_sharp,
                      children: getActions(context, state.competitor)),
                  slivers: <Widget>[
                    SliverAppBar(
                      leading: Container(
                          margin: const EdgeInsets.only(top: 8.0),
                          decoration: BoxDecoration(
                            color: colorScheme.brightness == Brightness.dark
                                ? colorScheme.surface
                                : colorScheme.primary,
                            borderRadius: const BorderRadius.only(
                                topRight: radius, bottomRight: radius),
                          ),
                          child: const BackButton()),
                      backgroundColor: Theme.of(context).cardColor,
                      floating: true,
                      elevation: 5.0,
                      flexibleSpace: Visibility(
                        visible: getImage(state.competitor).isNotEmpty,
                        child: CircleImage(
                            heroTag: args.competitorId,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: radius,
                              bottomRight: radius,
                            ),
                            height: 400,
                            fit: BoxFit.cover,
                            elevation: 15.0,
                            imageUrl: getImage(state.competitor)),
                      ),
                      expandedHeight: 400,
                      collapsedHeight: 100,
                    ),
                    SliverFillRemaining(
                        hasScrollBody: false,
                        child: _renderHeaderContent(context, state.competitor, bloc)),
                  ]);
            } else {
              return const Text('No Data');
            }
          },
        )));
  }

  List<SpeedDialChild> getActions(
      BuildContext context, DefaultState<CompetitorInfoState> state) {
    if (state is LoadedState) {
      final competitor = (state as LoadedState<CompetitorInfoState>).data;

      final linkColors = {
        SocialLink.facebook: Colors.indigo,
        SocialLink.twitter: Colors.blue,
        SocialLink.instagram: Colors.purple,
        SocialLink.web: Colors.lightBlueAccent,
      };

      final linkIcons = {
        SocialLink.facebook: CustomIcons.facebook,
        SocialLink.twitter: CustomIcons.twitter,
        SocialLink.instagram: CustomIcons.instagram,
        SocialLink.web: Icons.language,
      };

      final linkActions = competitor.links.map((link) {
        return SpeedDialChild(
          child: Icon(linkIcons[link.type]),
          foregroundColor: linkColors[link.type],
          onTap: () => launchURL(context, link.url),
        );
      });

      return [
        ...linkActions,
        SpeedDialChild(
          child: const Icon(Icons.video_library),
          foregroundColor: Colors.red,
          onTap: () {
            CompetitorVideosPage.navigate(context,
                arguments: CompetitorVideosArgs(
                    competitor.identifier, competitor.mainImage));
          },
        )
      ];
    } else {
      return [];
    }
  }

  Widget _renderHeaderContent(BuildContext context,
      DefaultState<CompetitorInfoState> state, CompetitorDetailBloc bloc) {
    if (state is LoadingState) {
      return Progress();
    } else if (state is ErrorState) {
      final errorState = state as ErrorState;
      return Center(child: NotificationMessage(errorState.message));
    } else {
      final competitor = (state as LoadedState<CompetitorInfoState>).data;
      return _renderCompetitorInfo(context, competitor, bloc);
    }
  }

  Widget _renderCompetitorInfo(BuildContext context,
      CompetitorInfoState competitor, CompetitorDetailBloc bloc) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(competitor.fullName(),
            style: Theme.of(context).textTheme.headline6),
        const SizedBox(
          height: 16.0,
        ),
        Text('Biography', style: Theme.of(context).textTheme.subtitle1),
        const SizedBox(
          height: 16.0,
        ),
        Text(competitor.biography),
        const SizedBox(
          height: 16.0,
        ),
        Text('Achievements', style: Theme.of(context).textTheme.subtitle1),
        const SizedBox(
          height: 16.0,
        ),
        Expanded(
            child: Column(
          children: [
            ..._renderAchievementGroups(context, competitor),
            VisibilityDetector(
                key: const Key('ad-competitor-visible-detector'),
                onVisibilityChanged: (visibilityInfo) {
                  final visiblePercentage =
                      visibilityInfo.visibleFraction * 100;

                  if (visiblePercentage > 0) {
                    bloc.onEnd();
                  }
                },
                child: Ad(
                  adUnitId: AdsHelper.competitorNativeAdUnitId,
                ))
          ],
        ))
      ]),
    );
  }

  String getImage(DefaultState<CompetitorInfoState> state) {
    if (state is LoadedState) {
      final competitor = (state as LoadedState<CompetitorInfoState>).data;
      return competitor.mainImage;
    } else {
      return args.imageUrl ?? '';
    }
  }

  List<Widget> _renderAchievementGroups(
      BuildContext context, CompetitorInfoState competitor) {
    final group = (String group) {
      final groupItems = competitor.achievements[group]!.map((achievement) {
        return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: achievement.position == 1
                ? GoldMedalIcon()
                : achievement.position == 2
                    ? SilverMedalIcon()
                    : BronzeMedalIcon(),
            title: Text(achievement.event.replaceFirst(group, ''),
                style: Theme.of(context).textTheme.bodyText2),
            trailing: Text(achievement.category,
                style: Theme.of(context).textTheme.bodyText2));
      }).toList();

      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(group, style: Theme.of(context).textTheme.subtitle2),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [...groupItems]))
      ]);
    };

    return competitor.achievements.keys.map((key) {
      return group(key);
    }).toList();
  }

  String getTitle(DefaultState<CompetitorInfoState> state) {
    if (state is LoadedState) {
      final competitor = (state as LoadedState<CompetitorInfoState>).data;
      return competitor.fullName();
    } else {
      return '';
    }
  }
}
