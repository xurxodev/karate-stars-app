import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:karate_stars_app/src/common/auth/api_credentials_loader.dart';
import 'package:karate_stars_app/src/common/data/remote/api_exceptions.dart';
import 'package:karate_stars_app/src/common/data/remote/token_storage.dart';

abstract class ApiDataSource {
  final String _baseAddress;
  final ApiTokenStorage _apiTokenStorage;
  final Credentials _apiCredentials;

  ApiDataSource(this._baseAddress, this._apiCredentials, this._apiTokenStorage);

  Future<http.Response> get(String endpoint) async {
    http.Response response;
    final token = await _apiTokenStorage.getToken();

    if (token.isEmpty) {
      response = await _renewTokenAndExecuteRequest(endpoint);
    } else {
      response = await _executeRequest(endpoint, token);

      if (response.statusCode == 401) {
        response = await _renewTokenAndExecuteRequest(endpoint);
      } else if (response.statusCode > 400) {
        throw UnKnowApiException(response.statusCode);
      }
    }

    return response;
  }

  Future<http.Response> _renewTokenAndExecuteRequest(String endpoint) async {
    final token = await _renewToken();
    await _apiTokenStorage.saveToken(token);

    return _executeRequest(endpoint, token);
  }

  Future<http.Response> _executeRequest(String endpoint, String token) async {
    try {
      print('_executeRequest');
      final response = await http.get(
        Uri.parse('$_baseAddress$endpoint'),
        headers: {
          HttpHeaders.acceptHeader: 'application/json',
          HttpHeaders.authorizationHeader: token
        },
      );
      return response;
    } on IOException {
      throw NetworkException();
    }
  }

  Future<String> _renewToken() async {
    try {
      print('_renewToken');
      final response = await http.post(Uri.parse('$_baseAddress/login'), body: {
        'username': _apiCredentials.username,
        'password': _apiCredentials.password
      });

      final authorizationHeader = response.headers[HttpHeaders.authorizationHeader];

      if (response.statusCode == 200 && authorizationHeader != null) {
        return authorizationHeader;
      } else {
        throw RenewTokenException();
      }
    } on Exception {
      throw RenewTokenException();
    }
  }
}
