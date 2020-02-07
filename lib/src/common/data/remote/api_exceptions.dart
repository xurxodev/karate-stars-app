class UnKnowApiException implements Exception{
  int httpCode;

  UnKnowApiException(this.httpCode);
}

class RenewTokenException implements Exception{}
class NetworkException implements Exception{}


