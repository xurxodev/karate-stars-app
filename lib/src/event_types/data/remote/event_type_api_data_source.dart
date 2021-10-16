import 'dart:convert';
import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/remote/api_data_source.dart';
import 'package:karate_stars_app/src/common/data/remote/token_storage.dart';
import 'package:karate_stars_app/src/event_types/data/remote/event_type_parser.dart';
import 'package:karate_stars_app/src/event_types/domain/entities/event_type.dart';

class EventTypeApiDataSource extends ApiDataSource
    implements ReadableDataSource<EventType> {
  final parser = EventTypeParser();

  EventTypeApiDataSource(String baseAddress, Credentials apiCredentials,
      ApiTokenStorage apiTokenStorage)
      : super(baseAddress, apiCredentials, apiTokenStorage);

  @override
  Future<List<EventType>> getAll() async {
    return await _fetchData();
  }

  Future<List<EventType>> _fetchData() async {
    final response = await super.get('/event-types');

    try {
      return parser.parse(json.decode(response.body));
    } on Exception {
      print(response.body);
      rethrow;
    }
  }
}
