import 'package:tever/model/common.dart';

class AppResource {
  List<CommonType> fetchedPromotionTypes;
  List<CommonType> fetchedCourierServices;
  List<CommonType> fetchedCountries;
  List<CommonType> fetchedStates;
  List<CommonType> fetchedDealDetailsCategory;
  List<CommonType> fetchedDealDetailsSubCategory;

  AppResource(
      {required this.fetchedDealDetailsCategory,
      required this.fetchedDealDetailsSubCategory,
      required this.fetchedCountries,
      required this.fetchedStates,
      required this.fetchedCourierServices,
      required this.fetchedPromotionTypes});

  factory AppResource.defaultState() {
    return AppResource(
      fetchedDealDetailsCategory: [],
      fetchedDealDetailsSubCategory: [],
      fetchedCourierServices: [],
      fetchedPromotionTypes: [],
      fetchedCountries: [],
      fetchedStates: [],
    );
  }

  AppResource copyWith({
    List<CommonType>? fetchedPromotionTypes,
    List<CommonType>? fetchedCourierServices,
    List<CommonType>? fetchedCountries,
    List<CommonType>? fetchedStates,
    List<CommonType>? fetchedDealDetailsCategory,
    List<CommonType>? fetchedDealDetailsSubCategory,
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
    );
  }
}
