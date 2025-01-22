final class A11YDetailPage {
  final String catbreeds;
  final String breedOrigin;
  final String breedIntelligence;
  final String breedAdaptability;
  final String breedTemperament;
  final String breedLifeSpan;
  final String breedAffectionLevel;
  final String breedChildFriendly;
  final String breedDogFriendly;
  final String breedEnergyLevel;
  final String breedGrooming;
  final String breedHealthIssues;
  final String breedSheddingLevel;
  final String breedSocialNeeds;
  final String breedStrangerFriendly;
  final String breedVocalisation;
  final String breedDescription;

  A11YDetailPage({
    required this.catbreeds,
    required this.breedOrigin,
    required this.breedIntelligence,
    required this.breedAdaptability,
    required this.breedTemperament,
    required this.breedLifeSpan,
    required this.breedAffectionLevel,
    required this.breedChildFriendly,
    required this.breedDogFriendly,
    required this.breedEnergyLevel,
    required this.breedGrooming,
    required this.breedHealthIssues,
    required this.breedSheddingLevel,
    required this.breedSocialNeeds,
    required this.breedStrangerFriendly,
    required this.breedVocalisation,
    required this.breedDescription,
  });

  factory A11YDetailPage.fromJson(Map<String, dynamic> json) => A11YDetailPage(
        catbreeds: json['catbreeds'],
        breedOrigin: json['breed-origin'],
        breedIntelligence: json['breed-intelligence'],
        breedAdaptability: json['breed-adaptability'],
        breedTemperament: json['breed-temperament'],
        breedLifeSpan: json['breed-life-span'],
        breedAffectionLevel: json['breed-affection-level'],
        breedChildFriendly: json['breed-child-friendly'],
        breedDogFriendly: json['breed-dog-friendly'],
        breedEnergyLevel: json['breed-energy-level'],
        breedGrooming: json['breed-grooming'],
        breedHealthIssues: json['breed-health-issues'],
        breedSheddingLevel: json['breed-shedding-level'],
        breedSocialNeeds: json['breed-social-needs'],
        breedStrangerFriendly: json['breed-stranger-friendly'],
        breedVocalisation: json['breed-vocalisation'],
        breedDescription: json['breed-description'],
      );
}
