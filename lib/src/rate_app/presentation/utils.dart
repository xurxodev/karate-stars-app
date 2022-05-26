import 'package:karate_stars_app/app_di.dart' as app_di;
import 'package:karate_stars_app/src/rate_app/domain/usecases/get_rate_app_use_case.dart';
import 'package:karate_stars_app/src/rate_app/domain/usecases/save_rate_app_use_case.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void> increaseAppRateConversionCount() async {
  final getRateAppUseCase = app_di.getIt<GetRateAppUseCase>();

  final rateApp = await getRateAppUseCase.execute();

  final increasedRateApp = rateApp.increaseConversionCount();
  print('increaseAppRateConversionCount: ${increasedRateApp.rateAppConversionCount}');

  final saveRateAppUseCase = app_di.getIt<SaveRateAppUseCase>();

  await saveRateAppUseCase.execute(increasedRateApp);
}

Future<void> updateAppRateLastRequestVersion() async {
  final getRateAppUseCase = app_di.getIt<GetRateAppUseCase>();

  final rateApp = await getRateAppUseCase.execute();
  final packageInfo = await PackageInfo.fromPlatform();

  final updateRateApp = rateApp.updateLastRequestVersion(packageInfo.version);
  print('updateAppRateLastRequestVersion: ${updateRateApp.lastRequestVersion}');

  final saveRateAppUseCase = app_di.getIt<SaveRateAppUseCase>();

  await saveRateAppUseCase.execute(updateRateApp);
}