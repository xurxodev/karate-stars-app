import 'dart:convert';

import 'package:karate_stars_app/src/categories/data/remote/category_parser.dart';
import 'package:karate_stars_app/src/categories/domain/entities/category.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/remote/api_data_source.dart';
import 'package:karate_stars_app/src/common/data/remote/token_storage.dart';

class CategoryApiDataSource extends ApiDataSource
    implements ReadableDataSource<Category> {
  final parser = CategoryParser();

  CategoryApiDataSource(String baseAddress, Credentials apiCredentials,
      ApiTokenStorage apiTokenStorage)
      : super(baseAddress, apiCredentials, apiTokenStorage);

  @override
  Future<List<Category>> getAll() async {
    return await _fetchData();
  }

  Future<List<Category>> _fetchData() async {
    final response = await super.get('/categories');

    try {
      return parser.parse(json.decode(response.body));
    } on Exception {
      print(response.body);
      rethrow;
    }
  }
}
