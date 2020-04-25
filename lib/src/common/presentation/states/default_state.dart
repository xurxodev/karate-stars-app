import 'package:flutter/material.dart';

abstract class DefaultState<T> {
  DefaultState();

  factory DefaultState.loading() => LoadingState();

  factory DefaultState.loaded(T data) =>  LoadedState(data: data);

  factory DefaultState.error(String message) => ErrorState(message: message);
}

class LoadingState<T> extends DefaultState<T> {}

class LoadedState<T> extends DefaultState<T> {
  final T data;

  LoadedState({@required this.data});
}

class ErrorState<T> extends DefaultState<T> {
  final String message;

  ErrorState({@required this.message});
}