import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/functions/url.dart';
import 'package:karate_stars_app/src/common/presentation/icons/custom_icons.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/CircleImage.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/CustomScrollViewWithFab.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/Progress.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/notification_message.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';
import 'package:karate_stars_app/src/competitors/presentation/blocs/competitor_detail_bloc.dart';

class CompetitorDetailArgs {
  final String competitorId;
  final String imageUrl;

  CompetitorDetailArgs(this.competitorId, this.imageUrl);
}

class CompetitorDetailPage extends StatelessWidget {
  final CompetitorDetailArgs args;

  const CompetitorDetailPage({required this.args});

  static Widget create(CompetitorDetailArgs args) {
    return BlocProvider(
        bloc: app_di.getIt<CompetitorDetailBloc>(),
        child: CompetitorDetailPage(args: args));
  }

  static const routeName = '/competitor';

  @override
  Widget build(BuildContext context) {
    final CompetitorDetailBloc bloc =
        BlocProvider.of<CompetitorDetailBloc>(context);
    bloc.init(args.competitorId);

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
              const radius = Radius.circular(60.0);
              return CustomScrollViewWithFab(
                  expandedHeight: 400,
                  floatingPosition: const FloatingPosition(right: 20.0),
                  floatingWidget: SpeedDial(
                      icon: Icons.navigate_next_sharp,
                      // backgroundColor: Colors.amber,
                      children: getActions(context, state)),
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
                      //forceElevated:true,
                      flexibleSpace: CircleImage(
                          heroTag: args.competitorId,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: radius,
                            bottomRight: radius,
                          ),
                          height: 400,
                          fit: BoxFit.cover,
                          elevation: 15.0,
                          imageUrl: getImage(state)),
                      expandedHeight: 400,
                      collapsedHeight: 100,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          if (index == 0) {
                            return _renderContent(context, state);
                          } else {
                            return ListTile(title: Text('title $index'));
                          }
                        },
                        childCount: 51,
                      ),
                    ),
                  ]);
            } else {
              return const Text('No Data');
            }
          },
        )));
  }

  List<SpeedDialChild> getActions(
      BuildContext context, DefaultState<Competitor> state) {
    if (state is LoadedState) {
      final competitor = (state as LoadedState<Competitor>).data;

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
            /* Do something */
          },
        )
      ];
    } else {
      return [];
    }
  }

  Widget _renderContent(BuildContext context, DefaultState<Competitor> state) {
    if (state is LoadingState) {
      return Progress();
    } else if (state is ErrorState) {
      final errorState = state as ErrorState;
      return Center(child: NotificationMessage(errorState.message));
    } else {
      final competitor = (state as LoadedState<Competitor>).data;
      return _renderCompetitorInfo(context, competitor);
    }
  }

  Widget _renderCompetitorInfo(BuildContext context, Competitor competitor) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(competitor.fullName(),
            style: Theme.of(context).textTheme.headline6),
        const SizedBox(
          height: 16.0,
        ),
        Text('Biography', style: Theme.of(context).textTheme.subtitle2),
        const SizedBox(
          height: 16.0,
        ),
        Text(competitor.biography),
        const SizedBox(
          height: 16.0,
        ),
        Text('Achievements', style: Theme.of(context).textTheme.subtitle2),
      ]),
    );
  }

  String getImage(DefaultState<Competitor> state) {
    if (state is LoadedState) {
      final competitor = (state as LoadedState<Competitor>).data;
      return competitor.mainImage;
    } else {
      return args.imageUrl;
    }
  }

  String getTitle(DefaultState<Competitor> state) {
    if (state is LoadedState) {
      final competitor = (state as LoadedState<Competitor>).data;
      return competitor.fullName();
    } else {
      return '';
    }
  }
}
