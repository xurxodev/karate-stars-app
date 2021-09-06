import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/blocs/bloc.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final T bloc;
  final Widget child;

  const BlocProvider({
    Key? key,
    required this.child,
    required this.bloc,
  }) : super(key: key);

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends Bloc>(BuildContext context) {
    final BlocProvider<T>? provider = context.findAncestorWidgetOfExactType();

    if (provider == null) {
      throw Exception('An error has ocurred finding bloc provider ancestor');
    } else {
      return provider.bloc;
    }
  }
}

class _BlocProviderState<T> extends State<BlocProvider<Bloc>> {
  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
