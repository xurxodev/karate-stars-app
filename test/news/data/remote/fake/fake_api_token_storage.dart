import 'package:karate_stars_app/src/common/data/remote/token_storage.dart';

class FakeApiTokenStorage implements ApiTokenStorage{
  String _token = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJiMTdlMDlmYy1kMmRhLTRiMGEtYjM0YS05MGVjYjdlMDgyZWMiLCJpYXQiOjE1ODEyMzE5MjMsImV4cCI6MTU4MTMxODMyM30.RE97tErg7i6L6fx67AdzajDH8UuD3cPrDNkdN6eov9I';
  @override
  Future<String> getToken() async {
    return _token;
  }

  @override
  Future<void> saveToken(String token) async {
    _token = token;
  }
}