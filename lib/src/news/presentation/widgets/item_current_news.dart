import 'package:flutter/material.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';

class ItemCurrentNews extends StatelessWidget {
  final CurrentNews currentNews;

  const ItemCurrentNews(this.currentNews);

  @override
  Widget build(BuildContext context) {
    return  Text(currentNews.summary.title);
  }
}
