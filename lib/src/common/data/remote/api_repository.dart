import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:karate_stars_app/src/common/auth/api_credentials_loader.dart';

abstract class ApiRepository {
  static const String baseAddress = 'https://karate-stars-api.herokuapp.com/v1';

  //static const String baseAddress = 'http://10.0.2.2:8000/v1';

  static const String tokenKey = 'tokenKey';

  final storage = const FlutterSecureStorage();

  Future<http.Response> get(String endpoint) async {
    http.Response response;
    final token = await _getToken();

    if (token == null || token.isEmpty) {
      response = await _renewTokenAndExecuteRequest(endpoint);
    } else {
      response = await _executeRequest(endpoint, token);

      if (response.statusCode == 401) {
        response = await _renewTokenAndExecuteRequest(endpoint);
      }
    }

    return response;
  }

  Future<http.Response> _renewTokenAndExecuteRequest(String endpoint) async {
    final token = await _renewToken();
    _saveToken(token);

    return _executeRequest(endpoint, token);
  }

  Future<http.Response> _executeRequest(String endpoint, String token) async {
    try {
      final response = await http.get(
        '$baseAddress$endpoint',
        headers: {HttpHeaders.authorizationHeader: token},
      );
      return response;
    } on Exception catch (e) {
      return Future.error(
          Exception('Failed to execute request: ${e.toString()}'));
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
        return Future.error(
            Exception('Failed to renew token:${response.reasonPhrase}'));
      }
    } on Exception catch (e) {
      return Future.error(Exception('Failed to renew token: ${e.toString()}'));
    }
  }

  Future<String> _getToken() async {
    return await storage.read(key: tokenKey);
  }

  Future<void> _saveToken(String token) async {
    return await storage.write(key: tokenKey, value: token);
  }
}
