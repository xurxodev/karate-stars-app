import 'dart:convert';

import 'package:karate_stars_app/src/common/auth/credentials.dart';
import 'package:karate_stars_app/src/common/data/data_sources_contracts.dart';
import 'package:karate_stars_app/src/common/data/remote/api_data_source.dart';
import 'package:karate_stars_app/src/common/data/remote/token_storage.dart';
import 'package:karate_stars_app/src/events/data/remote/event_parser.dart';
import 'package:karate_stars_app/src/events/domain/entities/event.dart';

class EventApiDataSource extends ApiDataSource
    implements ReadableDataSource<Event> {
  final parser = EventParser();

  EventApiDataSource(String baseAddress, Credentials apiCredentials,
      ApiTokenStorage apiTokenStorage)
      : super(baseAddress, apiCredentials, apiTokenStorage);

  @override
  Future<List<Event>> getAll() async {
    return await _fetchData();
  }

  Future<List<Event>> _fetchData() async {
    final response = await super.get('/events');

    try {
      return parser.parse(json.decode(response.body));
    } on Exception {
      print(response.body);
      rethrow;
    }
  }
}
