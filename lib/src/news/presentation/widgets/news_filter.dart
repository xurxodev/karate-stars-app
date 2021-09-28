import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/filters/SegmentedFilter.dart';
import 'package:karate_stars_app/src/news/presentation/blocs/news_bloc.dart';
import 'package:karate_stars_app/src/news/presentation/states/news_filter_state.dart';
import 'package:karate_stars_app/src/news/presentation/states/news_state.dart';

class NewsFilter extends StatelessWidget {
  final NewsBloc bloc;

  const NewsFilter({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<NewsState>(
      initialData: bloc.state,
      stream: bloc.observableState,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          return _buildFilter(context, snapshot.data!.filtersState, bloc);
        } else {
          return const Text('No data');
        }
      },
    );
  }

  Widget _buildFilter(
      BuildContext context, NewsFilterState state, NewsBloc bloc) {
    return SegmentedFilter(
      options: state.filterOptions,
      onValueChanged: (int index) {
        bloc.filter(index);
      },
      value: state.selectedIndex,
    );
  }
}
