import 'dart:convert';

import 'package:karate_stars_app/src/common/auth/api_credentials_loader.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/remote/api_data_source.dart';
import 'package:karate_stars_app/src/common/data/remote/token_storage.dart';
import 'package:karate_stars_app/src/competitors/data/remote/competitor_parser.dart';
import 'package:karate_stars_app/src/competitors/domain/entities/competitor.dart';

class CompetitorApiDataSource extends ApiDataSource
    implements ReadableDataSource<Competitor> {
  final parser = CompetitorParser();

  CompetitorApiDataSource(String baseAddress, Credentials apiCredentials,
      ApiTokenStorage apiTokenStorage)
      : super(baseAddress, apiCredentials, apiTokenStorage);

  @override
  Future<List<Competitor>> getAll() async {
    return await _fetchCompetitors();
  }

  Future<List<Competitor>> _fetchCompetitors() async {
    final response = await super.get('/competitors');

    try {
      return parser.parse(json.decode(response.body));
    } on Exception{
      print(response.body);
      rethrow;
    }
  }
}
