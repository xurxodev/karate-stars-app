import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class ApiTokenStorage {
  Future<String> getToken();

  Future<void> saveToken(String token);
}

class ApiTokenSecureStorage implements ApiTokenStorage{
  static const String tokenKey = 'tokenKey';
  final storage = const FlutterSecureStorage();

  @override
  Future<String> getToken() async {
    final value =  await storage.read(key: tokenKey);

    return value ?? '';
  }

  @override
  Future<void> saveToken(String token) async {
    return await storage.write(key: tokenKey, value: token);
  }
}
