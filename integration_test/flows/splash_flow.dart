import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../common/common.dart';
import 'finders/cat_breeds_finders.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  setUp(() {});

  testWidgets(
    'IT_01_01: should go to the splash page',
    (WidgetTester tester) async {
      // arrange
      await Test.initApp(tester);

      // assert
      await ValidateFindsOneWidget.validate(tester, CatBreedsFinders.splashPage);
    },
  );
}
