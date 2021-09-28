import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/filters/SegmentedFilter.dart';
import 'package:karate_stars_app/src/competitors/presentation/blocs/competitors_bloc.dart';
import 'package:karate_stars_app/src/competitors/presentation/states/competitors_filter_state.dart';
import 'package:karate_stars_app/src/competitors/presentation/states/competitors_state.dart';

class CompetitorFilters extends StatelessWidget {
  final CompetitorsBloc bloc;

  const CompetitorFilters({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<CompetitorsState>(
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

  Widget _buildFilter(BuildContext context, CompetitorsFilterState state,
      CompetitorsBloc bloc) {
    return Column(
      children: [
        SegmentedFilter(
          options: state.legendTypeOptions,
          onValueChanged: (int index) {
            bloc.filter(selectedLegendTypeIndex: index);
          },
          value: state.selectedLegendType,
        ),
        SegmentedFilter(
          options: state.activeTypeOptions,
          onValueChanged: (int index) {
            bloc.filter(selectedActiveIndex: index);
          },
          value: state.selectedActiveType,
        ),
      ],
    );
  }
}
