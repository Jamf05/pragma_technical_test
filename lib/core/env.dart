import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Env {
  late PackageInfo packageInfo;
  static final Env _instance = Env._internal();
  Env._internal();

  static Future<Env> load({
    String fileName = '.env',
    Parser parser = const Parser(),
    Map<String, String> mergeWith = const <String, String>{},
  }) async {
    await dotenv.load(fileName: fileName, parser: parser, mergeWith: mergeWith);
    return _instance;
  }

  static String get api => dotenv.env['API_URL'] ?? '';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';

  static String get networkPlaceholder => dotenv.env['NETWORK_PLACEHOLDER'] ?? '';

  static String get environment => dotenv.env['ENVIRONMENT'] ?? '';
  static bool get bannerEnvironment =>
      dotenv.env['BANNER_ENVIRONMENT']?.contains('true') == true;
  static String get appName => _instance.packageInfo.appName;
  static String get appID => _instance.packageInfo.packageName;
  static String get version => _instance.packageInfo.version + _versionSuffix;
  static String get buildNumber => _instance.packageInfo.buildNumber;
  static String get releaseDate => dotenv.env['RELEASE_DATE'] ?? '';

  static String get _versionSuffix {
    final String versionSuffix = dotenv.env['VERSION_SUFFIX'] ?? '';
    final String stageNumber = dotenv.env['VERSION_STAGE_NUMBER'] ?? '';
    if (versionSuffix.isNotEmpty && stageNumber.isNotEmpty) {
      return '-$versionSuffix.$stageNumber';
    } else if (versionSuffix.isNotEmpty && stageNumber.isEmpty) {
      return versionSuffix;
    } else {
      return '';
    }
  }
}
