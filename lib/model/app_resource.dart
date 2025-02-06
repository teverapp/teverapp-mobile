import 'package:tever/model/common.dart';

class AppResource {
  List<CommonType> fetchedPromotionTypes;
  List<CommonType> fetchedCourierServices;
  List<CommonType> fetchedCountries;
  List<CommonType> fetchedStates;
  List<CommonType> fetchedDealDetailsCategory;
  List<CommonType> fetchedDealDetailsSubCategory;
  List<CommonType> termsAndCoditions;

  AppResource({
    required this.fetchedDealDetailsCategory,
    required this.fetchedDealDetailsSubCategory,
    required this.fetchedCountries,
    required this.fetchedStates,
    required this.fetchedCourierServices,
    required this.fetchedPromotionTypes,
    required this.termsAndCoditions,
  });

  factory AppResource.defaultState() {
    return AppResource(
        fetchedDealDetailsCategory: [],
        fetchedDealDetailsSubCategory: [],
        fetchedCourierServices: [],
        fetchedPromotionTypes: [],
        fetchedCountries: [],
        fetchedStates: [],
        termsAndCoditions: []);
  }

  AppResource copyWith({
    List<CommonType>? fetchedPromotionTypes,
    List<CommonType>? fetchedCourierServices,
    List<CommonType>? fetchedCountries,
    List<CommonType>? fetchedStates,
    List<CommonType>? fetchedDealDetailsCategory,
    List<CommonType>? fetchedDealDetailsSubCategory,
    List<CommonType>? termsAndCoditions,
  }) {
    return AppResource(
      fetchedDealDetailsCategory:
          fetchedDealDetailsCategory ?? this.fetchedDealDetailsCategory,
      fetchedCountries: fetchedCountries ?? this.fetchedCountries,
      fetchedStates: fetchedStates ?? this.fetchedStates,
      fetchedDealDetailsSubCategory:
          fetchedDealDetailsSubCategory ?? this.fetchedDealDetailsSubCategory,
      fetchedCourierServices:
          fetchedCourierServices ?? this.fetchedCourierServices,
      fetchedPromotionTypes:
          fetchedPromotionTypes ?? this.fetchedPromotionTypes,
      termsAndCoditions: termsAndCoditions ?? this.termsAndCoditions,
    );
  }
}
