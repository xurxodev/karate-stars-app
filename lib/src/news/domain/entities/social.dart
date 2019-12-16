import 'package:karate_stars_app/src/news/domain/entities/news.dart';
import 'package:karate_stars_app/src/news/domain/entities/pub_date.dart';
import 'package:karate_stars_app/src/news/domain/entities/summary.dart';

enum Network { twitter }

class SocialNews extends News {
  final Network network;
  final SocialUser user;

  SocialNews(NewsSummary summary, this.network, this.user)
      : assert(network != null),
        assert(user != null),
        super(summary);
}

class SocialUser {
  final String name;
  final String userName;
  final String image;
  final String url;

  SocialUser(this.name, this.userName, this.image, this.url)
      : assert(name != null),
        assert(userName != null),
        assert(image != null),
        assert(url != null);
}

