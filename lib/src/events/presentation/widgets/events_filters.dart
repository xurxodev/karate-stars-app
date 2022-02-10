import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/states/option.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/filters/FilterGroup.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_dropdown.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/events/presentation/blocs/events_bloc.dart';
import 'package:karate_stars_app/src/events/presentation/state/events_filter_state.dart';
import 'package:karate_stars_app/src/events/presentation/state/events_state.dart';

class EventsFilters extends StatelessWidget {
  final EventsBloc bloc;

  const EventsFilters({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EventsState>(
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

  Widget _buildFilter(
      BuildContext context, EventsFilterState state, EventsBloc bloc) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterGroup(
          label: Strings.events_filters_event_type_label,
          child: Container(
            width: double.infinity,
            child: PlatformDropdown(
              options: state.eventTypeOptions,
              value: state.selectedEventType,
              onChanged: (Option? option) {
                bloc.filter(selectedEventType: option);
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        FilterGroup(
          label: Strings.events_filters_year_label,
          child: Container(
            width: double.infinity,
            child: PlatformDropdown(
              options: state.yearOptions,
              value: state.selectedYear,
              onChanged: (Option? option) {
                bloc.filter(selectedYear: option);
              },
            ),
          ),
        ),
      ],
    );
  }
}
