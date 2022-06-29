import 'package:karate_stars_app/src/common/domain/read_policy.dart';
import 'package:karate_stars_app/src/rankings/domain/boundaries/ranking_entry_repository.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/rankingEntry.dart';

class GetRankingEntriesUseCase {
  final RankingEntryRepository _rankingEntryRepository;

  GetRankingEntriesUseCase(this._rankingEntryRepository);

  Future<List<RankingEntry>> execute(
      ReadPolicy readPolicy, String rankingId, String categoryId) async {
    final rankingEntries = await _rankingEntryRepository
        .getByRankingAndCategory(readPolicy, rankingId, categoryId);

    return rankingEntries;
  }
}
