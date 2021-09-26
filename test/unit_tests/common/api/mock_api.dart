import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mock_web_server/mock_web_server.dart';

const getCurrentNewsResponse = '/get_current_news_response.json';
const getSocialNewsResponse = '/get_social_news_response.json';
const getCompetitorsResponse = '/get_competitors_response.json';
const getCountriesResponse = '/get_countries_response.json';
const loginResponse = '/login_response.json';
const anyTokenHeader =
    'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJiMTdlMDlmYy1kMmRhLTRiMGEtYjM0YS05MGVjYjdlMDgyZWMiLCJpYXQiOjE1ODE2MTAwNzYsImV4cCI6MTU4MTY5NjQ3Nn0.CY-fpMO0A7b95e4m-cWdbfxTR_yI0aaVolucPZ1D3wo';

class MockApi {
  final MockWebServer _server = MockWebServer();

  Future<void> start() async {
    await _server.start();
  }

  void shutdown() {
    _server.shutdown();
  }

  String get baseAddress => _server.url.substring(0, _server.url.length - 1);

  Future<void> enqueueMockResponse(
      {String fileName = '',
      int httpCode = 200,
      Map<String, String>? headers}) async {
    final content = await _getContentFromFile(fileName: fileName);

    _server.enqueue(body: content, httpCode: httpCode, headers: headers);
  }

  Future<void> enqueueUnauthorizedResponse(
      {String fileName = '', int httpCode = 200}) async {
    enqueueMockResponse(httpCode: 401);
  }

  Future<void> enqueueLoginResponse(
      {String token = anyTokenHeader, int httpCode = 200}) async {
    enqueueMockResponse(
        fileName: loginResponse, headers: {'authorization': token});
  }

  void expectRequestSentTo(String endpoint) {
    final StoredRequest storedRequest = _server.takeRequest();

    expect(storedRequest.uri.path, endpoint);
  }

  void expectRequestContainsHeader(String key, String expectedValue,
      [int requestIndex = 0]) {
    final StoredRequest storedRequest =
        _getRecordedRequestAtIndex(requestIndex);
    final value = storedRequest.headers[key];

    expect(value, expectedValue);
  }

  Future<String> _getContentFromFile(
      {String testResourcesDir = '/unit_tests/common/api/resources',
      required String fileName}) async {
    if (fileName.isEmpty) {
      return '';
    }

    final String content =
        await File(_testPath(testResourcesDir + fileName)).readAsString();

    return content;
  }

  String _testPath(String relativePath) {
    //Fix ide test path
    final Directory current = Directory.current;
    final String path =
        current.path.endsWith('/test') ? current.path : current.path + '/test';

    return path + '/' + relativePath;
  }

  StoredRequest _getRecordedRequestAtIndex(int requestIndex) =>
      List<StoredRequest>.generate(
          requestIndex + 1, (i) => _server.takeRequest()).last;
}
