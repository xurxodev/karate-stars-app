import 'package:karate_stars_app/src/competitors/domain/boundaries/competitor_repository.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/social_news_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrentNewsRepository extends Mock implements CurrentNewsRepository {}

class MockSocialNewsRepository extends Mock implements SocialNewsRepository {}

class MockCompetitorRepository extends Mock implements CompetitorRepository {}
