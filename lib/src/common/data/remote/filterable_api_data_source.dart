import 'dart:convert';

import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/remote/api_data_source.dart';
import 'package:karate_stars_app/src/common/data/remote/token_storage.dart';
import 'package:karate_stars_app/src/rankings/data/remote/ranking_entry_parser.dart';

class FilterableApiDataSource<Entity> extends ApiDataSource {
  final Parser<Entity> _parser;
  final String _endpoint;

  FilterableApiDataSource(String baseAddress, this._endpoint,
      Credentials apiCredentials, ApiTokenStorage apiTokenStorage, this._parser)
      : super(baseAddress, apiCredentials, apiTokenStorage);

  Future<List<Entity>> getByFilters(Map<String, dynamic> filters) {
    return _fetchData(filters);
  }

  Future<List<Entity>> _fetchData(Map<String, dynamic> filters) async {
    final queryString =
    filters.keys.map((key) => '$key=${filters[key]}').join('&');
    final response = await super.get('/$_endpoint?$queryString');

    try {
      return _parser.parse(json.decode(response.body));
    } on Exception {
      print(response.body);
      rethrow;
    }
  }
}

