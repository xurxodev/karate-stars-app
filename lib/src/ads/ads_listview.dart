import 'dart:async';

import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/app/app_bloc.dart';
import 'package:karate_stars_app/src/app/app_state.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc_provider.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';

typedef IndexedWidgetBuilder = Widget Function(BuildContext context, int index);

abstract class Item {}

class AdItem implements Item {}

class OriginalItem implements Item {
  final int originalIndex;

  OriginalItem(this.originalIndex);
}

class AdsListView extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Widget Function(BuildContext context) adBuilder;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;

  const AdsListView(
      {required this.itemCount,
      required this.itemBuilder,
      required this.adBuilder,
      this.padding,
      this.controller});

  @override
  _AdsListViewState createState() => _AdsListViewState();
}

class _AdsListViewState extends State<AdsListView> {
  static const _itemsPerAd = 8;

  List<Item> virtualItems = [];
  bool isPremium = false;

  late StreamSubscription<AppState> _appStateSubscription;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      final appBloc = BlocProvider.of<AppBloc>(context);

      generateByPremium(appBloc.state);

      _appStateSubscription = appBloc.observableState.listen((state) {
        generateByPremium(state);
      });
    });
  }

  void generateByPremium(DefaultState<AppStateData> state) {
    if (state is LoadedState<AppStateData>) {
      final isPremium = state.data.isPremium;

      setState(() {
        this.isPremium = isPremium;
      });

      _generateVirtualItems();
    } else {
      _generateVirtualItems();
    }
  }

  @override
  void didUpdateWidget(AdsListView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.itemCount != oldWidget.itemCount) {
      _generateVirtualItems();
    }
  }

  void _generateVirtualItems() {
    final items = Iterable<int>.generate(widget.itemCount).map((i) {
      final Item item = OriginalItem(i);
      return item;
    }).toList();

    if (!isPremium) {
      if (items.length <= _itemsPerAd) {
        items.insert(items.length, AdItem());
      } else {
        for (int i = _itemsPerAd; i <= items.length; i += _itemsPerAd) {
          items.insert(i, AdItem());
        }
      }
    }

    setState(() {
      virtualItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: widget.controller,
        padding: widget.padding,
        itemCount: virtualItems.length,
        itemBuilder: (context, index) {
          if (virtualItems[index] is AdItem) {
            return widget.adBuilder(context);
          } else {
            final item = virtualItems[index] as OriginalItem;
            return widget.itemBuilder(context, item.originalIndex);
          }
        });
  }

  @override
  void dispose() {
    _appStateSubscription.cancel();
    super.dispose();
  }
}
