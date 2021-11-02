import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/platform/platform_widget.dart';
import 'package:karate_stars_app/src/common/strings.dart';
import 'package:karate_stars_app/src/search/presentation/blocs/search_bloc.dart';

const double _kTabHeight = 46.0;

class SearchAppBar extends PlatformWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize =
      const Size.fromHeight(kToolbarHeight + _kTabHeight);

  final _controller = TextEditingController();

  @override
  Widget createMaterialWidget(BuildContext context) {
    final SearchBloc bloc = BlocProvider.of<SearchBloc>(context);

    return AppBar(
      automaticallyImplyLeading: false,
      leading: const BackButton(),
      title: TextField(
        controller: _controller,
        decoration: const InputDecoration.collapsed(
            hintText: Strings.search_app_bar_hint),
        onChanged: (query) {
          bloc.search(query);
        },
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _controller.clear();
            bloc.search('');
          },
        ),
      ],
      bottom: TabBar(
        labelColor: Theme.of(context).textTheme.headline6!.color,
        indicatorColor: Theme.of(context).textTheme.headline6!.color,
        tabs: const [
          Tab(text: Strings.search_news_title),
          Tab(text: Strings.search_competitor_title),
          Tab(text: Strings.search_videos_title),
        ],
      ),
    );
  }

  @override
  Widget createCupertinoWidget(BuildContext context) {
    final SearchBloc bloc = BlocProvider.of<SearchBloc>(context);

    return AppBar(
      automaticallyImplyLeading: false,
      title: CupertinoSearchTextField(
        style: Theme.of(context).textTheme.bodyText2,
        placeholder: Strings.search_app_bar_hint,
        onChanged: (query) {
          bloc.search(query);
        },
      ),
      actions: [
        CupertinoButton(
          child: Text('Cancel',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontSize: 18)),
          //padding: const EdgeInsets.symmetric(horizontal: 8.0),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
      bottom: TabBar(
        labelColor: Theme.of(context).textTheme.headline6!.color,
        indicatorColor: Theme.of(context).textTheme.headline6!.color,
        tabs: const [
          Tab(text: Strings.search_news_title),
          Tab(text: Strings.search_competitor_title),
          Tab(text: Strings.search_videos_title),
        ],
      ),
    );
  }
}
