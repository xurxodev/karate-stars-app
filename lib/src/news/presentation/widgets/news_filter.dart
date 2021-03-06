import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/news/presentation/blocs/news_bloc.dart';
import 'package:karate_stars_app/src/news/presentation/states/news_filter_state.dart';

class NewsFilter extends StatelessWidget {
  final NewsBloc bloc;

  const NewsFilter({this.bloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<NewsFilterState>(
      initialData: bloc.initialFilter,
      stream: bloc.filter,
      builder: (context, snapshot) {
        return _buildFilter(context, snapshot.data, bloc);
      },
    );
  }

  Widget _buildFilter(
      BuildContext context, NewsFilterState state, NewsBloc bloc) {
    return CupertinoSlidingSegmentedControl(
      thumbColor: Theme.of(context).accentColor,
      children:
          state.filterOptions.map((key, value) => MapEntry(key, Text(value))),
      onValueChanged: (index) {
        bloc.filterSink.add(NewsFilterState(selectedIndex: index));
      },
      groupValue: state.selectedIndex,
    );
  }
}
