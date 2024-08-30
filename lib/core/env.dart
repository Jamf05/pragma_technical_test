import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
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
}
