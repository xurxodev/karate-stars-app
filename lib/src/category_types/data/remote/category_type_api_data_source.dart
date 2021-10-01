import 'dart:convert';

import 'package:karate_stars_app/src/category_types/data/remote/category_type_parser.dart';
import 'package:karate_stars_app/src/category_types/domain/entities/category_type.dart';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/remote/api_data_source.dart';
import 'package:karate_stars_app/src/common/data/remote/token_storage.dart';

class CategoryTypeApiDataSource extends ApiDataSource
    implements ReadableDataSource<CategoryType> {
  final parser = CategoryTypeParser();

  CategoryTypeApiDataSource(String baseAddress, Credentials apiCredentials,
      ApiTokenStorage apiTokenStorage)
      : super(baseAddress, apiCredentials, apiTokenStorage);

  @override
  Future<List<CategoryType>> getAll() async {
    return await _fetchData();
  }

  Future<List<CategoryType>> _fetchData() async {
    final response = await super.get('/category-types');

    try {
      return parser.parse(json.decode(response.body));
    } on Exception {
      print(response.body);
      rethrow;
    }
  }
}
