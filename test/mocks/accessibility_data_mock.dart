import 'package:pragma_technical_test/presentation/shared/models/a_11_y_detail_page.dart';
import 'package:pragma_technical_test/presentation/shared/models/a_11_y_landing_page.dart';

final class AccessibilityDataMock {
  static final Map<String, dynamic> json = {
    'landing-page': {
      'catbreeds': 'Catbreeds, title',
      'breed-name': 'Breed {{0}}',
      'more-button': 'See more details, button',
      'breed-origin': 'Originating from {{0}}',
      'breed-temperament': 'With a temperament of {{0}}'
    },
    'detail-page': {
      'catbreeds': 'Catbreeds, title',
      'breed-origin': 'Originating from {{0}}',
      'breed-intelligence': 'Intelligence level, {{0}} out of {{1}}',
      'breed-adaptability': 'Adaptability {{0}} out of {{1}}',
      'breed-temperament': 'With a temperament of {{0}}',
      'breed-life-span': 'Life expectancy from {{0}} to {{1}} years',
      'breed-affection-level': 'Affection level {{0}} out of {{1}}',
      'breed-child-friendly': 'Child-friendly level {{0}} out of {{1}}',
      'breed-dog-friendly': 'Dog-friendly level {{0}} out of {{1}}',
      'breed-energy-level': 'Energy level {{0}} out of {{1}}',
      'breed-grooming': 'Grooming level {{0}} out of {{1}}',
      'breed-health-issues': 'Health issues level {{0}} out of {{1}}',
      'breed-shedding-level': 'Shedding level {{0}} out of {{1}}',
      'breed-social-needs': 'Social needs level {{0}} out of {{1}}',
      'breed-stranger-friendly': 'Stranger-friendly level {{0}} out of {{1}}',
      'breed-vocalisation': 'Vocalisation level {{0}} out of {{1}}',
      'breed-description': 'Description, {{0}}'
    }
  };

  static final A11YLandingPage a11YLandingPageMock =
      A11YLandingPage.fromJson(json['landing-page']);
  
  static final A11YDetailPage a11YDetailPageMock =
      A11YDetailPage.fromJson(json['detail-page']);
}
