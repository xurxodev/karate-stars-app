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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FilterGroup(
            label: Strings.competitor_filters_type_label,
            child: SegmentedOptions(
              options: state.legendTypeOptions,
              onValueChanged: (String id) {
                bloc.filter(selectedLegendType: id);
              },
              value: state.selectedLegendType,
            )),
        const SizedBox(height: 20),
        FilterGroup(
          label: Strings.competitor_filters_active_label,
          child: SegmentedOptions(
            options: state.activeTypeOptions,
            onValueChanged: (String id) {
              bloc.filter(selectedActiveType: id);
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
              options: state.countryOptions,
              value: state.selectedCountry,
              onChanged: (String id) {
                bloc.filter(selectedCountry: id);
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        FilterGroup(
          label: Strings.competitor_filters_category_type_label,
          child: Container(
            width: double.infinity,
            child: PlatformDropdown(
              options: state.categoryTypeOptions,
              value: state.selectedCategoryType,
              onChanged: (String id) {
                bloc.filter(selectedCategoryType: id);
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        FilterGroup(
          label: Strings.competitor_filters_category_label,
          child: Container(
            width: double.infinity,
            child: PlatformDropdown(
              options: state.categoryOptions,
              value: state.selectedCategory,
              onChanged: (String id) {
                bloc.filter(selectedCategory: id);
              },
            ),
          ),
        ),
      ],
    );
  }
}
