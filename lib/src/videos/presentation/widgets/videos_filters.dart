import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/states/option.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/filters/FilterGroup.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_dropdown.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/videos/presentation/blocs/videos_bloc.dart';
import 'package:karate_stars_app/src/videos/presentation/states/videos_filter_state.dart';
import 'package:karate_stars_app/src/videos/presentation/states/videos_state.dart';

class VideosFilters extends StatelessWidget {
  final VideosBloc bloc;

  const VideosFilters({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<VideosState>(
      initialData: bloc.state,
      stream: bloc.observableState,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return _buildFilter(context, snapshot.data!.filters, bloc);
        } else {
          return const Text('No data');
        }
      },
    );
  }

  Widget _buildFilter(BuildContext context, VideosFilterState state,
      VideosBloc bloc) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterGroup(
          label: Strings.video_filters_competitor_label,
          child: Container(
            width: double.infinity,
            child: PlatformDropdown(
              options: state.competitorOptions,
              value: state.selectedCompetitor,
              onChanged: (Option? option) {
                bloc.filter(
                    selectedCompetitor: option);
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        FilterGroup(
          label: Strings.video_filters_year_label,
          child: Container(
            width: double.infinity,
            child: PlatformDropdown(
              options: state.yearOptions,
              value: state.selectedYear,
              onChanged: (Option? option) {
                bloc.filter(
                    selectedYear: option);
              },
            ),
          ),
        ),
      ],
    );
  }
}
