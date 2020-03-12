import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';

abstract class NewsState {

  NewsState();

  factory NewsState.loading() => NewsLoadingState();

  factory NewsState.loaded(List<News> result) =>  NewsLoadedState(news: result);

  factory NewsState.error(String message) => NewsErrorState(message: message);
}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  final List<News> news;

  NewsLoadedState({@required this.news});
}

class NewsErrorState extends NewsState {
  final String message;

  NewsErrorState({@required this.message});
}