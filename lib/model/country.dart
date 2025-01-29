class Country {
  final String name;
  final String flag;
  final String phoneCode;
  final String countryCode;

  Country({
    required this.name,
    required this.flag,
    required this.phoneCode,
    required this.countryCode,
  });

  factory Country.defaultState() {
    return Country(
      name: "Nigeria",
      flag: "🇳🇬",
      phoneCode: "+234",
      countryCode: "NG",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'flag': flag,
      'phoneCode': phoneCode,
      'countryCode': countryCode,
    };
  }

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] ?? "",
      flag: json['flag'] ?? "",
      phoneCode: json['phoneCode'] ?? "",
      countryCode: json['countryCode'] ?? "",
    );
  }
}
