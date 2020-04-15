import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';

abstract class CompetitorRepository{
  Future<List<Competitor>> getAll(ReadPolicy readPolicy);
}