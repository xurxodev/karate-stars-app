import 'dart:convert';

import 'package:flutter/services.dart';

class Credentials {
  final String username;
  final String password;

  Credentials(this.username, this.password);

  factory Credentials.fromJson(Map<String, dynamic> jsonMap) {
    return Credentials(jsonMap['username'], jsonMap['password']);
  }
}

class ApiCredentialsLoader {
  final String credentialsPath;

  ApiCredentialsLoader(this.credentialsPath);

  Future<Credentials> load() {
    return rootBundle.loadStructuredData<Credentials>(credentialsPath,
        (jsonStr) async {
      return Credentials.fromJson(json.decode(jsonStr));
    });
  }
}
