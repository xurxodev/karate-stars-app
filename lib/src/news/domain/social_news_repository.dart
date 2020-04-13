import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/news/domain/entities/social.dart';

abstract class SocialNewsRepository{
  Stream<List<SocialNews>> getSocialNews(ReadPolicy readPolicy);
}