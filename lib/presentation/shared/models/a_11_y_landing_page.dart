import 'package:equatable/equatable.dart';

final class A11YLandingPage extends Equatable {
  final String catbreeds;
  final String breedName;
  final String moreButton;
  final String breedOrigin;
  final String breedTemperament;

  const A11YLandingPage({
    required this.catbreeds,
    required this.breedName,
    required this.moreButton,
    required this.breedOrigin,
    required this.breedTemperament,
  });

  factory A11YLandingPage.fromJson(Map<String, dynamic> json) =>
      A11YLandingPage(
        catbreeds: json['catbreeds'],
        breedName: json['breed-name'],
        moreButton: json['more-button'],
        breedOrigin: json['breed-origin'],
        breedTemperament: json['breed-temperament'],
      );
  
  @override
  List<Object?> get props => [catbreeds, breedName, moreButton, breedOrigin, breedTemperament];
}
