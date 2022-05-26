class RateApp {
  final String lastRequestVersion;
  final String currentVersion;
  final int rateAppConversionCount;
  static const rateAppConversionRequired = 15;

  RateApp(this.currentVersion, this.lastRequestVersion,
      this.rateAppConversionCount);

  Future<bool> isRequestRateAppRequired() async {
    return rateAppConversionCount >= rateAppConversionRequired &&
        lastRequestVersion != currentVersion;
  }

  RateApp increaseConversionCount() {
    return RateApp(
        currentVersion, lastRequestVersion, rateAppConversionCount + 1);
  }

  RateApp updateLastRequestVersion(String version) {
    return RateApp(currentVersion, version, 0);
  }
}
