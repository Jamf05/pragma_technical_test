import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pragma_technical_test/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('splash', () {
    app.main();
  });

  group('landing', () {

  });

  group('detail', () {

  });
}