import 'package:karate_stars_app/src/categories/domain/boundaries/category_repository.dart';
import 'package:karate_stars_app/src/category_types/domain/boundaries/category_type_repository.dart';
import 'package:karate_stars_app/src/competitors/domain/boundaries/competitor_repository.dart';
import 'package:karate_stars_app/src/countries/domain/boundaries/country_repository.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/current_news_repository.dart';
import 'package:karate_stars_app/src/news/domain/boundaries/social_news_repository.dart';
import 'package:karate_stars_app/src/settings/domain/boundaries/settings_repository.dart';
import 'package:karate_stars_app/src/videos/domain/boundaries/video_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockCurrentNewsRepository extends Mock implements CurrentNewsRepository {}

class MockSocialNewsRepository extends Mock implements SocialNewsRepository {}

class MockCompetitorRepository extends Mock implements CompetitorRepository {}

class MockCountryRepository extends Mock implements CountryRepository {}

class MockCategoryTypeRepository extends Mock
    implements CategoryTypeRepository {}

class MockCategoryRepository extends Mock implements CategoryRepository {}

class MockVideoRepository extends Mock implements VideoRepository {}

class MockSettingsRepository extends Mock implements SettingsRepository {}
