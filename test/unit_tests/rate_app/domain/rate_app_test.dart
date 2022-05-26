import 'package:karate_stars_app/src/rate_app/domain/entities/rate_app.dart';
import 'package:test/test.dart';

void main() {
  group('RateApp should', () {
    test('return required false if last version is not equal to current and'
        ' conversions is lower than required', () async {
      final rateApp =  RateApp('2.5.1', '', 0);

      expect(await rateApp.isRequestRateAppRequired(), false);
    });
    test('return required false if last version is equal to current and'
        ' conversions is equal to required', () async {
      final rateApp =  RateApp('2.5.1','2.5.1', RateApp.rateAppConversionRequired);

      expect(await rateApp.isRequestRateAppRequired(), false);
    });
    test('return required false if last version is not equal to current and'
        ' conversions is lower than required', () async {
      final rateApp =  RateApp('2.5.2','2.5.1', RateApp.rateAppConversionRequired -1);

      expect(await rateApp.isRequestRateAppRequired(), false);
    });
    test('return required true if last version is not equal to current and'
        ' conversions is equal to required', () async {
      final rateApp =  RateApp('2.5.2','2.5.1', RateApp.rateAppConversionRequired);

      expect(await rateApp.isRequestRateAppRequired(), true);
    });
    test('return required true if last version is not equal to current and'
        ' conversions is greater than  required', () async {
      final rateApp =  RateApp('2.5.2','2.5.1', RateApp.rateAppConversionRequired +1);

      expect(await rateApp.isRequestRateAppRequired(), true);
    });
  });
}
