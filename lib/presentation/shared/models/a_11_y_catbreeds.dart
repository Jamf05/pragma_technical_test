import 'package:equatable/equatable.dart';
import 'package:pragma_technical_test/presentation/shared/models/a_11_y_detail_page.dart';
import 'package:pragma_technical_test/presentation/shared/models/a_11_y_landing_page.dart';

final class A11YCatbreeds extends Equatable {
  final A11YLandingPage a11YLandingPage;
  final A11YDetailPage a11YDetailPage;

  const A11YCatbreeds({
    required this.a11YLandingPage,
    required this.a11YDetailPage,
  });

  factory A11YCatbreeds.fromJson(Map<String, dynamic> json) => A11YCatbreeds(
        a11YLandingPage: A11YLandingPage.fromJson(json['landing-page']),
        a11YDetailPage: A11YDetailPage.fromJson(json['detail-page']),
      );
  
  @override
  List<Object?> get props => [a11YLandingPage, a11YDetailPage];
}
