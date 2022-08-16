import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  AppInfo._singleTon();

  static final AppInfo _instance = AppInfo._singleTon();

  factory AppInfo() {
    return _instance;
  }

  late PackageInfo _packageInfo;

  Future<void> initPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  String get version => _packageInfo.version;
  String get buildNumber => _packageInfo.buildNumber;
}
