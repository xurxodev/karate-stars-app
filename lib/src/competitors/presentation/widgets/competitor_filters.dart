import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/filters/FilterGroup.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/filters/SegmentedFilter.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_dropdown.dart';
import 'package:karate_stars_app/src/common/strings.dart';
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
    final countryOptions = state.countryOptions
        .map((country) => Option(country.id, country.name))
        .toList();
    final selectedCountryOption = state.selectedCountry != null
        ? Option(state.selectedCountry!.id, state.selectedCountry!.name)
        : null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterGroup(
            label: Strings.competitor_filters_type_label,
            child: SegmentedFilter(
              options: state.legendTypeOptions,
              onValueChanged: (int index) {
                bloc.filter(selectedLegendTypeIndex: index);
              },
              value: state.selectedLegendType,
            )),
        const SizedBox(height: 20),
        FilterGroup(
          label: Strings.competitor_filters_active_label,
          child: SegmentedFilter(
            options: state.activeTypeOptions,
            onValueChanged: (int index) {
              bloc.filter(selectedActiveIndex: index);
            },
            value: state.selectedActiveType,
          ),
        ),
        const SizedBox(height: 10),
        FilterGroup(
            label: Strings.competitor_filters_country_label,
            child: Container(
              width: double.infinity,
              child: PlatformDropdown(
                options: countryOptions,
                value: selectedCountryOption,
                onChanged: (Option? option) {
                  bloc.filter(
                      selectedCountry: state.countryOptions
                          .firstWhere((country) => country.id == option?.id));
                },
                hint: Strings.competitor_filters_country_hint,
              ),
            )),
      ],
    );
  }
}
