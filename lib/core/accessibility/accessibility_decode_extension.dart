import 'package:pragma_technical_test/core/accessibility/accessibility_params.dart';

extension AccessibilityDecodeExtension on String {
  String decodeWith1Param(
    String param0,
  ) {
    return replaceAll(AccessibilityParams.with1.value, param0);
  }

  String decodeWith2Params(
    String param0,
    String param1,
  ) {
    return replaceAll(AccessibilityParams.with1.value, param0)
        .replaceAll(AccessibilityParams.with2.value, param1);
  }
}
