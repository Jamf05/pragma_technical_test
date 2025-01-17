import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_technical_test/presentation/pages/detail/detail_page.dart';
import 'package:pragma_technical_test/presentation/pages/landing/landing_page.dart';
import 'package:pragma_technical_test/presentation/shared/page/splash_page.dart';

final class CatBreedsFinders {
  // pages
  static final Finder splashPage = find.byType(SplashPage);
  static final Finder landingPage = find.byType(LandingPage);
  static final Finder detailPage = find.byType(DetailPage);

  // widgets
  static final Finder textField = find.byType(TextField);
  static final Finder scrollable = find.byType(Scrollable);

  // elements
  static final materialApp = find.byType(MaterialApp);
  static final Finder fristBreedPage0 =
      find.byKey(const Key('ptt_item_cat_breed_card_abys_key'));
  static final Finder lastBreedPage0 =
      find.byKey(const Key('ptt_item_cat_breed_card_bamb_key'));
  static final Finder lastBreedPage1 =
      find.byKey(const Key('ptt_item_cat_breed_card_char_key'));
  static final Finder aegeCatBreed =
      find.byKey(const Key('ptt_item_cat_breed_card_aege_key'));
  static final wbSunnyOutlinedIcon = find.byIcon(Icons.wb_sunny_outlined);
  static final nightlightRoundIcon = find.byIcon(Icons.nightlight_round);

  // lists
  static final Finder landingListViewKey =
      find.byKey(const Key('ptt_list_view_key'));
  static final Finder landingPageListScroll = find.descendant(
    of: landingListViewKey,
    matching: find.byType(Scrollable),
  );

  // buttons
  static final Finder textButtonFristBreedPage0 = find.descendant(
    of: fristBreedPage0,
    matching: find.byType(TextButton),
  );
  static final Finder landingThemeButtonKey =
      find.byKey(const Key('ptt_landing_theme_button_key'));
}
