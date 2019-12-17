import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';

abstract class NewsState {

  NewsState();

  factory NewsState.loading() => Loading();

  factory NewsState.loaded(List<News> result) =>  Loaded(news: result);
}

class Loading extends NewsState {}

class Loaded extends NewsState {
  final List<News> news;

  Loaded({@required this.news});
}