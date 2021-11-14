import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

@module
abstract class AppInformation {
  @preResolve
  Future<PackageInfo> get prefs => init();
}

Future<PackageInfo> init() async {
  final versionInfo = await PackageInfo.fromPlatform();
  return versionInfo;
}
