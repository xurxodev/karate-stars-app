import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/summary.dart';

enum Network { twitter, instagram, facebook }

class SocialNews extends News {
  final Network network;
  final SocialUser user;

  SocialNews(NewsSummary summary, this.network, this.user) : super(summary);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SocialNews &&
          runtimeType == other.runtimeType &&
          network == other.network &&
          summary == other.summary &&
          user == other.user;

  @override
  int get hashCode => network.hashCode ^ summary.hashCode ^ user.hashCode;
}

class SocialUser {
  final String name;
  final String userName;
  final String image;
  final String url;

  SocialUser(this.name, this.userName, this.image, this.url);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SocialUser &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          userName == other.userName &&
          image == other.image &&
          url == other.url;

  @override
  int get hashCode =>
      name.hashCode ^ userName.hashCode ^ image.hashCode ^ url.hashCode;
}
