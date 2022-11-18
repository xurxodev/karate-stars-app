import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/global_di.dart' as app_di;
import 'package:karate_stars_app/src/ads/ad.dart';
import 'package:karate_stars_app/src/ads/ads_helper.dart';
import 'package:karate_stars_app/src/ads/interstitial_ad.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/CircleImage.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/Progress.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/notification_message.dart';
import 'package:karate_stars_app/src/competitors/presentation/states/competitor_detail_state.dart';
import 'package:karate_stars_app/src/videos/presentation/blocs/competitor_videos_bloc.dart';
import 'package:karate_stars_app/src/videos/presentation/pages/video_player_page.dart';
import 'package:karate_stars_app/src/videos/presentation/states/competitor_videos_state.dart';
import 'package:karate_stars_app/src/videos/presentation/widgets/item_video.dart';

class CompetitorVideosArgs {
  final String competitorId;
  final String imageUrl;

  CompetitorVideosArgs(this.competitorId, this.imageUrl);
}

class CompetitorVideosPage extends StatefulWidget {
  final CompetitorVideosArgs args;
  static const routeName = '/competitor-videos';

  const CompetitorVideosPage({required this.args});

  static void navigate(BuildContext context,
      {required CompetitorVideosArgs arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  static Widget create(CompetitorVideosArgs args) {
    return BlocProvider(
        bloc: app_di.getIt<CompetitorVideosBloc>(),
        child: CompetitorVideosPage(args: args));
  }

  @override
  State<CompetitorVideosPage> createState() => _CompetitorVideosPageState();
}

class _CompetitorVideosPageState extends State<CompetitorVideosPage> {
  late PlayVideoInterstitialAd _playVideoInterstitialAd;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      _playVideoInterstitialAd = PlayVideoInterstitialAd(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final CompetitorVideosBloc bloc =
        BlocProvider.of<CompetitorVideosBloc>(context);
    bloc.init(widget.args.competitorId);

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
        backgroundColor: Theme.of(context).cardColor,
        body: SafeArea(
            child: StreamBuilder<CompetitorVideosState>(
          initialData: bloc.state,
          stream: bloc.observableState,
          builder: (context, snapshot) {
            final state = snapshot.data;

            if (state != null) {
              const radius = Radius.circular(60.0);
              return CustomScrollView(slivers: <Widget>[
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
                      heroTag: widget.args.competitorId,
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
                SliverFillRemaining(
                    hasScrollBody: false,
                    child: _renderContent(context, state)),
              ]);
            } else {
              return const Text('No Data');
            }
          },
        )));
  }

  Widget _renderContent(BuildContext context, CompetitorVideosState state) {
    if (state is LoadingState) {
      return Progress();
    } else if (state is ErrorState) {
      final errorState = state as ErrorState;
      return Center(child: NotificationMessage(errorState.message));
    } else {
      final competitor = (state as LoadedState<CompetitorVideos>).data;
      return _renderCompetitorVideos(context, competitor);
    }
  }

  Widget _renderCompetitorVideos(
      BuildContext context, CompetitorVideos competitorVideos) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: double.infinity,
          color: Theme.of(context).cardColor,
          padding: const EdgeInsets.all(16.0),
          child: Text(competitorVideos.name,
              style: Theme.of(context).textTheme.headline6),
        ),
        Expanded(
            child: Column(
          children: [..._renderVideos(context, competitorVideos)],
        )),
      ]),
    );
  }

  String getImage(CompetitorVideosState state) {
    if (state is LoadedState) {
      final data = (state as LoadedState<CompetitorVideos>).data;
      return data.image;
    } else {
      return widget.args.imageUrl;
    }
  }

  List<Widget> _renderVideos(
      BuildContext context, CompetitorVideos competitorVideos) {
    final items = competitorVideos.videos.map((video) {
      return ItemVideo(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.blueGrey[50]
            : Colors.grey[600],
        video: video,
        onTap: () async {
          _playVideoInterstitialAd.show();
          VideoPlayerPage.navigate(context,
              arguments: VideoPlayerPageArgs(videoId: video.id));
        },
      );
    }).toList();

    if (items.length > 8) {
      return [
        ...items.getRange(0, 7),
        Ad(
          adUnitId: AdsHelper.videosNativeAdUnitId,
        ),
        ...items.getRange(7, items.length),
      ];
    } else {
      return [
        ...items,
        Ad(
          adUnitId: AdsHelper.videosNativeAdUnitId,
        )
      ];
    }
  }

  String getTitle(DefaultState<CompetitorInfoState> state) {
    if (state is LoadedState) {
      final competitor = (state as LoadedState<CompetitorInfoState>).data;
      return competitor.fullName();
    } else {
      return '';
    }
  }

  @override
  void dispose() {
    _playVideoInterstitialAd.dispose();
    super.dispose();
  }
}
