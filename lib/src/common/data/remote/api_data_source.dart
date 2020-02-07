import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:karate_stars_app/src/common/auth/api_credentials_loader.dart';
import 'package:karate_stars_app/src/common/data/remote/api_exceptions.dart';
import 'package:karate_stars_app/src/common/data/remote/token_storage.dart';

abstract class ApiDataSource {
  static const String baseAddress = 'https://karate-stars-api.herokuapp.com/v1';
  //static const String baseAddress = 'http://10.0.2.2:8000/v1';

  final ApiTokenStorage _apiTokenStorage;

  ApiDataSource(this._apiTokenStorage);

  Future<http.Response> get(String endpoint) async {
    http.Response response;
    final token = await _apiTokenStorage.getToken();

    if (token == null || token.isEmpty) {
      response = await _renewTokenAndExecuteRequest(endpoint);
    } else {
      response = await _executeRequest(endpoint, token);

      if (response.statusCode == 401) {
        response = await _renewTokenAndExecuteRequest(endpoint);
      } else if (response.statusCode > 400){
        throw UnKnowApiException(response.statusCode);
      }
    }

    return response;
  }

  Future<http.Response> _renewTokenAndExecuteRequest(String endpoint) async {
    final token = await _renewToken();
    _apiTokenStorage.saveToken(token);

    return _executeRequest(endpoint, token);
  }

  Future<http.Response> _executeRequest(String endpoint, String token) async {
    try {
      final response = await http.get(
        '$baseAddress$endpoint',
        headers: {HttpHeaders.authorizationHeader: token},
      );
      return response;
    } on IOException {
      throw NetworkException();
    }
  }

  Future<String> _renewToken() async {
    try {
      final credentials =
          await ApiCredentialsLoader('assets/credentials.json').load();

      final response = await http.post('$baseAddress/login', body: {
        'username': credentials.username,
        'password': credentials.password
      });

      if (response.statusCode == 200) {
        return response.headers[HttpHeaders.authorizationHeader];
      } else {
        throw RenewTokenException();
      }
    } on Exception catch (e) {
      throw RenewTokenException();
    }
  }
}
