import 'package:karate_stars_app/src/common/presentation/states/default_state.dart';
import 'package:karate_stars_app/src/news/domain/entities/current.dart';
import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/videos/domain/entities/video.dart';

abstract class HomeItem<T> {
  final T content;

  HomeItem(this.content);

  factory HomeItem.news(News item) {
    return HomeNewsItem(item) as HomeItem<T>;
  }

  factory HomeItem.topNews(List<CurrentNews> items) {
    return HomeTopNewsItem(items) as HomeItem<T>;
  }

  factory HomeItem.lastVideos(List<Video> items) {
    return HomeLastVideoItem(items) as HomeItem<T>;
  }
}

class HomeNewsItem extends HomeItem<News> {
  HomeNewsItem(News content) : super(content);
}

class HomeTopNewsItem extends HomeItem<List<CurrentNews>> {
  HomeTopNewsItem(List<CurrentNews> content) : super(content);
}

class HomeLastVideoItem extends HomeItem<List<Video>> {
  HomeLastVideoItem(List<Video> content) : super(content);
}

class HomeState {
  final DefaultState<List<HomeItem>> listState;

  HomeState({required this.listState});

  HomeState copyWith(
      {DefaultState<List<HomeItem>>? listState}) {
    return HomeState(
        listState: listState ?? this.listState);
  }
}
