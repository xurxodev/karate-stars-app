import 'dart:convert';

import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/remote/api_data_source.dart';
import 'package:karate_stars_app/src/common/data/remote/token_storage.dart';
import 'package:karate_stars_app/src/rankings/data/remote/ranking_parser.dart';
import 'package:karate_stars_app/src/rankings/domain/entities/ranking.dart';

class RankingApiDataSource extends ApiDataSource
    implements ReadableDataSource<Ranking> {
  final parser = RankingParser();

  RankingApiDataSource(String baseAddress, Credentials apiCredentials,
      ApiTokenStorage apiTokenStorage)
      : super(baseAddress, apiCredentials, apiTokenStorage);

  @override
  Future<List<Ranking>> getAll() async {
    return await _fetchData();
  }

  Future<List<Ranking>> _fetchData() async {
    final response = await super.get('/rankings');

    try {
      return parser.parse(json.decode(response.body));
    } on Exception {
      print(response.body);
      rethrow;
    }
  }
}
