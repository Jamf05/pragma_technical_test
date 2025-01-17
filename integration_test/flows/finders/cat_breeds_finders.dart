import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_technical_test/presentation/pages/landing/landing_page.dart';
import 'package:pragma_technical_test/presentation/shared/page/splash_page.dart';

final class CatBreedsFinders {
  static final Finder splashPage = find.byType(SplashPage);
  static final Finder landingPage = find.byType(LandingPage);

  static final Finder lastBreedPage0 = find.byKey(const Key('ptt_item_cat_breed_card_bamb_key'));
  static final Finder lastBreedPage1 = find.byKey(const Key('ptt_item_cat_breed_card_char_key'));
  static final Finder landingListViewKey = find.byKey(const Key('ptt_list_view_key'));
  static final Finder landingPageListScroll = find.descendant(
    of: landingListViewKey,
    matching: find.byType(Scrollable),
  );
}
