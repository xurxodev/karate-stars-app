import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/Progress.dart';
import 'package:karate_stars_app/src/common/presentation/widgets/message.dart';

class DefaultStateStreamBuilder<T> extends StatelessWidget {
  final DefaultState<T> initialData;
  final Stream<DefaultState<T>> stream;
  final AsyncWidgetBuilder<DefaultState<T>> builder;

  const DefaultStateStreamBuilder(
      {required this.builder, required this.initialData, required this.stream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DefaultState<T>>(
      initialData: initialData,
      stream: stream,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state != null) {
          if (state is LoadingState) {
            return Progress();
          } else if (state is ErrorState) {
            final listState = state as ErrorState;
            return Center(
              child: Message(text: listState.message, type: MessageType.error),
            );
          } else {
            return builder(context, snapshot);
          }
        } else {
          return const Text('No Data');
        }
      },
    );
  }
}
