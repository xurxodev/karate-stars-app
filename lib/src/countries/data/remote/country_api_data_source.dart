import 'dart:convert';

import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/remote/api_data_source.dart';
import 'package:karate_stars_app/src/common/data/remote/token_storage.dart';
import 'package:karate_stars_app/src/countries/data/remote/country_parser.dart';
import 'package:karate_stars_app/src/countries/domain/entities/country.dart';

class CountryApiDataSource extends ApiDataSource
    implements ReadableDataSource<Country> {
  final parser = CountryParser();

  CountryApiDataSource(String baseAddress, Credentials apiCredentials,
      ApiTokenStorage apiTokenStorage)
      : super(baseAddress, apiCredentials, apiTokenStorage);

  @override
  Future<List<Country>> getAll() async {
    return await _fetchCompetitors();
  }

  Future<List<Country>> _fetchCompetitors() async {
    final response = await super.get('/countries');

    try {
      return parser.parse(json.decode(response.body));
    } on Exception {
      print(response.body);
      rethrow;
    }
  }
}
