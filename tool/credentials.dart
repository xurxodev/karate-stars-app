import 'dart:io';

Future<void> main() async {
  final apiUserName = Platform.environment['API_USERNAME'];
  final apiPassword = Platform.environment['API_PASSWORD'];

  const filename = 'assets/credentials.json';
  File(filename).writeAsString('''
  {
    "username": "$apiUserName",
    "password": "$apiPassword"
  }
  ''');
}