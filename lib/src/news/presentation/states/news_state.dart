import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';

abstract class NewsState {

  NewsState();

  //factory NewsState.empty() => Empty();

  factory NewsState.loading() => Loading();

  factory NewsState.loaded(List<News> result) =>  Loaded(news: result);
}

/*class Empty extends NewsState {
  final List<News> result = [];

  Empty();
}*/


class Loading extends NewsState {}

class Loaded extends NewsState {
  final List<News> news;

  Loaded({@required this.news});
}

/*
class Error extends NewsState {
  final String message;

  Error({@required this.message}):super();
}*/
