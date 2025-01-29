import 'dart:io';

import 'package:tever/model/common.dart';

class NewDeal {
  CommonType? type;
  List<CommonType> dealDetailsCategory;
  List<CommonType> dealDetailsSubCategory;
  List<CommonType> countries;
  List<CommonType> fetchedStates;
  List<CommonType> colors;
  List<CommonType> materials;
  List<CommonType> sizes;
  List<CommonType> earningValues;
  List<DocumentFile> selectedTermsAndPolicy;
  String? categoryId;
  String? subCategoryId;
  String? category;
  String? subCategory;
  String? title;
  String? description;
  String? price;
  String? dealPromotionType;
  String? dealPromotionValue;
  String? dealPromotionCode;
  String? dealPromotionValidDate;
  String? dealPromotionAffliateMarketingEarningValue;
  bool? requiredCustomerToInputCodeDuringCheckOut;
  File? dealPromotionMaterialImage;
  List<File?>? dealDetailsImages;
  List<NewDeailsDetailsVarient> varient;
  bool contactForQuote;
  bool showAddAVarientBtn;
  String? shippingFromCountry;
  String? shippingFromCountryId;
  String? shippingToRegion;
  String? shippingToContinent;
  String? shippingToContinentId;
  String? shippingToCountry;
  String? shippingToCountryId;
  // String? shippingToState;
  // String? shippingToCity;
  bool? showShippingRateCard;
  String? shippingRateCourierservice;
  String? shippingRate;
  String? shippingRateEstimatedDeliveryTime;
  List<LocationSelection>? selectedCountries;
  List<LocationSelection>? selectedStates;
  bool showAddPromotionMaterialCard;
  bool showAddAffliateMarketingCard;
  String? noOfRoomsForCleaning;
  String? duration;
  String? spaceLocationCountry;
  String? selectedCountryFromAllCountryId;
  String? spaceLocationAddress;
  String? spaceLocationCity;
  String? spaceLocationState;
  String? capacity;
  String? dimension;
  String? contactInfoCountryFlag;
  String? contactInfoCountryPhoneCode;
  String? contactInfoCountryAcronym;
  bool? contactInfoPhoneNumberError;
  String? contactInfoPhoneNumber;
  String? contactInfoBrandName;
  String? contactInfoAboutBrand;
  String? contactInfoEmail;
  bool? contactInfoEmailError;
  String? contactInfoAddress;
  List<CommonType> fetchedPromotionType;
  List<CommonType> fetchedCourierService;

  NewDeal({
    required this.type,
    required this.colors,
    required this.sizes,
    required this.materials,
    required this.dealDetailsCategory,
    required this.dealDetailsSubCategory,
    required this.categoryId,
    required this.subCategoryId,
    required this.category,
    required this.subCategory,
    required this.title,
    required this.description,
    required this.price,
    required this.dealDetailsImages,
    required this.varient,
    required this.contactForQuote,
    required this.showAddAVarientBtn,
    required this.dealPromotionType,
    required this.dealPromotionValue,
    required this.dealPromotionCode,
    required this.dealPromotionValidDate,
    required this.dealPromotionAffliateMarketingEarningValue,
    required this.requiredCustomerToInputCodeDuringCheckOut,
    required this.dealPromotionMaterialImage,
    required this.countries,
    required this.fetchedStates,
    required this.shippingFromCountry,
    required this.shippingToRegion,
    required this.shippingToCountry,
    required this.shippingToCountryId,
    // required this.shippingToState,
    // required this.shippingToCity,
    required this.shippingToContinent,
    required this.shippingToContinentId,
    required this.showShippingRateCard,
    required this.shippingRateCourierservice,
    required this.shippingRate,
    required this.shippingRateEstimatedDeliveryTime,
    required this.selectedCountries,
    required this.selectedStates,
    required this.showAddPromotionMaterialCard,
    required this.showAddAffliateMarketingCard,
    required this.noOfRoomsForCleaning,
    required this.duration,
    required this.spaceLocationCountry,
    required this.selectedCountryFromAllCountryId,
    required this.spaceLocationAddress,
    required this.spaceLocationCity,
    required this.spaceLocationState,
    required this.capacity,
    required this.dimension,
    required this.contactInfoCountryFlag,
    required this.contactInfoCountryPhoneCode,
    required this.contactInfoCountryAcronym,
    required this.contactInfoPhoneNumberError,
    required this.contactInfoPhoneNumber,
    required this.contactInfoBrandName,
    required this.contactInfoAboutBrand,
    required this.contactInfoEmail,
    required this.contactInfoEmailError,
    required this.contactInfoAddress,
    required this.fetchedPromotionType,
    required this.earningValues,
    required this.selectedTermsAndPolicy,
    required this.fetchedCourierService,
  });

  factory NewDeal.defaultState() {
    return NewDeal(
      type: dealTypeDropdownItems[0],
      dealDetailsCategory: [],
      dealDetailsSubCategory: [],
      categoryId: null,
      subCategoryId: null,
      category: null,
      subCategory: null,
      title: "",
      description: "",
      price: "",
      dealDetailsImages: [null, null, null],
      varient: [],
      contactForQuote: false,
      showAddAVarientBtn: true,
      dealPromotionType: null,
      dealPromotionValue: "",
      dealPromotionCode: "",
      dealPromotionValidDate: null,
      dealPromotionAffliateMarketingEarningValue: null,
      requiredCustomerToInputCodeDuringCheckOut: false,
      dealPromotionMaterialImage: null,
      countries: [],
      fetchedStates: [],
      shippingFromCountry: null,
      shippingToRegion: null,
      shippingToCountry: null,
      shippingToCountryId: null,
      // shippingToState: null,
      // shippingToCity: null,
      shippingToContinent: null,
      shippingToContinentId: null,
      showShippingRateCard: false,
      shippingRateCourierservice: null,
      shippingRate: null,
      shippingRateEstimatedDeliveryTime: null,
      selectedCountries: [],
      selectedStates: [],
      showAddPromotionMaterialCard: false,
      showAddAffliateMarketingCard: false,
      noOfRoomsForCleaning: null,
      duration: null,
      spaceLocationCountry: null,
      selectedCountryFromAllCountryId: null,
      spaceLocationAddress: "",
      spaceLocationCity: "",
      spaceLocationState: null,
      capacity: "",
      dimension: "",
      contactInfoCountryFlag: null,
      contactInfoCountryPhoneCode: null,
      contactInfoCountryAcronym: null,
      contactInfoPhoneNumberError: true,
      contactInfoPhoneNumber: "",
      contactInfoBrandName: "",
      contactInfoAboutBrand: "",
      contactInfoEmail: "",
      contactInfoEmailError: true,
      contactInfoAddress: "",
      fetchedPromotionType: [],
      selectedTermsAndPolicy: [],
      fetchedCourierService: [],
      colors: [
        CommonType(id: "1", name: "Red"),
        CommonType(id: "2", name: "Blue"),
        CommonType(id: "3", name: "Green"),
        CommonType(id: "4", name: "Yellow"),
        CommonType(id: "5", name: "Purple"),
        CommonType(id: "6", name: "Orange"),
        CommonType(id: "7", name: "Black"),
        CommonType(id: "8", name: "White"),
        CommonType(id: "9", name: "Gray"),
        CommonType(id: "10", name: "Brown"),
      ],
      materials: [
        CommonType(id: "1", name: "Wood"),
        CommonType(id: "2", name: "Plastic"),
        CommonType(id: "3", name: "Rubber"),
        CommonType(id: "4", name: "Fabric"),
        CommonType(id: "5", name: "Metal"),
        CommonType(id: "6", name: "Glass"),
        CommonType(id: "7", name: "Paper"),
        CommonType(id: "8", name: "Leather"),
        CommonType(id: "9", name: "Stone"),
        CommonType(id: "10", name: "Ceramic"),
      ],
      sizes: [
        CommonType(id: "1", name: "Extra Small"),
        CommonType(id: "2", name: "Small"),
        CommonType(id: "3", name: "Medium"),
        CommonType(id: "4", name: "Large"),
        CommonType(id: "5", name: "Extra Large"),
      ],
      earningValues: [
        CommonType(
          id: "1",
          name: "10% on every sale",
        ),
        CommonType(
          id: "2",
          name: "20% on every sale",
        ),
        CommonType(
          id: "3",
          name: "30% on every sale",
        ),
      ],
    );
  }

  NewDeal copyWith({
    CommonType? type,
    List<CommonType>? dealDetailsCategory,
    List<CommonType>? dealDetailsSubCategory,
    List<CommonType>? countries,
    List<CommonType>? allCountries,
    List<CommonType>? fetchedStates,
    String? categoryId,
    String? subCategoryId,
    String? category,
    String? subCategory,
    String? title,
    String? description,
    String? price,
    List<File?>? dealDetailsImages,
    List<NewDeailsDetailsVarient>? varient,
    bool? contactForQuote,
    bool? showAddAVarientBtn,
    String? dealPromotionType,
    String? dealPromotionValue,
    String? dealPromotionCode,
    String? dealPromotionValidDate,
    String? dealPromotionAffliateMarketingEarningValue,
    bool? requiredCustomerToInputCodeDuringCheckOut,
    File? dealPromotionMaterialImage,
    String? shippingFromCountry,
    String? shippingToRegion,
    String? shippingToCountry,
    String? shippingToCountryId,
    // String? shippingToState,
    // String? shippingToCity,
    String? shippingToContinent,
    String? shippingToContinentId,
    bool? showShippingRateCard,
    String? shippingRateCourierservice,
    String? shippingRate,
    String? shippingRateEstimatedDeliveryTime,
    List<LocationSelection>? selectedCountries,
    List<LocationSelection>? selectedStates,
    bool? showAddPromotionMaterialCard,
    bool? showAddAffliateMarketingCard,
    String? noOfRoomsForCleaning,
    String? duration,
    String? spaceLocationCountry,
    String? selectedCountryFromAllCountryId,
    String? spaceLocationAddress,
    String? spaceLocationCity,
    String? spaceLocationState,
    String? capacity,
    String? dimension,
    String? contactInfoCountryFlag,
    String? contactInfoCountryPhoneCode,
    String? contactInfoCountryAcronym,
    bool? contactInfoPhoneNumberError,
    String? contactInfoPhoneNumber,
    String? contactInfoBrandName,
    String? contactInfoAboutBrand,
    String? contactInfoEmail,
    bool? contactInfoEmailError,
    String? contactInfoAddress,
    List<CommonType>? fetchedPromotionType,
    List<CommonType>? colors,
    List<CommonType>? materials,
    List<CommonType>? sizes,
    List<CommonType>? earningValues,
    List<DocumentFile>? selectedTermsAndPolicy,
    List<CommonType>? fetchedCourierService,
  }) {
    print(
        "copyWith called. New value: $category, Current value: ${subCategory}");
    return NewDeal(
      type: type ?? this.type,
      dealDetailsCategory: dealDetailsCategory ?? this.dealDetailsCategory,
      countries: countries ?? this.countries,
      fetchedStates: fetchedStates ?? this.fetchedStates,
      dealDetailsSubCategory:
          dealDetailsSubCategory ?? this.dealDetailsSubCategory,
      categoryId: categoryId ?? this.categoryId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      dealDetailsImages: dealDetailsImages ?? this.dealDetailsImages,
      varient: varient ?? this.varient,
      contactForQuote: contactForQuote ?? this.contactForQuote,
      showAddAVarientBtn: showAddAVarientBtn ?? this.showAddAVarientBtn,
      dealPromotionType: dealPromotionType ?? this.dealPromotionType,
      dealPromotionValue: dealPromotionValue ?? this.dealPromotionValue,
      dealPromotionCode: dealPromotionCode ?? this.dealPromotionCode,
      dealPromotionValidDate:
          dealPromotionValidDate ?? this.dealPromotionValidDate,
      dealPromotionAffliateMarketingEarningValue:
          dealPromotionAffliateMarketingEarningValue ??
              this.dealPromotionAffliateMarketingEarningValue,
      requiredCustomerToInputCodeDuringCheckOut:
          requiredCustomerToInputCodeDuringCheckOut ??
              this.requiredCustomerToInputCodeDuringCheckOut,
      dealPromotionMaterialImage:
          dealPromotionMaterialImage ?? this.dealPromotionMaterialImage,
      shippingFromCountry: shippingFromCountry ?? this.shippingFromCountry,
      shippingToRegion: shippingToRegion ?? this.shippingToRegion,
      shippingToCountry: shippingToCountry ?? this.shippingToCountry,
      shippingToCountryId: shippingToCountryId ?? this.shippingToCountryId,
      shippingToContinent: shippingToContinent ?? this.shippingToContinent,
      shippingToContinentId:
          shippingToContinentId ?? this.shippingToContinentId,
      // shippingToState: shippingToState ?? this.shippingToState,
      // shippingToCity: shippingToCity ?? this.shippingToCity,
      showShippingRateCard: showShippingRateCard ?? this.showShippingRateCard,
      shippingRateCourierservice:
          shippingRateCourierservice ?? this.shippingRateCourierservice,
      shippingRate: shippingRate ?? this.shippingRate,
      shippingRateEstimatedDeliveryTime: shippingRateEstimatedDeliveryTime ??
          this.shippingRateEstimatedDeliveryTime,
      selectedCountries: selectedCountries ?? this.selectedCountries,
      selectedStates: selectedStates ?? this.selectedStates,
      showAddPromotionMaterialCard:
          showAddPromotionMaterialCard ?? this.showAddPromotionMaterialCard,
      showAddAffliateMarketingCard:
          showAddAffliateMarketingCard ?? this.showAddAffliateMarketingCard,
      noOfRoomsForCleaning: noOfRoomsForCleaning ?? this.noOfRoomsForCleaning,
      duration: duration ?? this.duration,
      spaceLocationCountry: spaceLocationCountry ?? this.spaceLocationCountry,
      selectedCountryFromAllCountryId: selectedCountryFromAllCountryId ??
          this.selectedCountryFromAllCountryId,
      spaceLocationAddress: spaceLocationAddress ?? this.spaceLocationAddress,
      spaceLocationCity: spaceLocationCity ?? this.spaceLocationCity,
      spaceLocationState: spaceLocationState ?? this.spaceLocationState,
      capacity: capacity ?? this.capacity,
      dimension: dimension ?? this.dimension,
      contactInfoCountryFlag:
          contactInfoCountryFlag ?? this.contactInfoCountryFlag,
      contactInfoCountryPhoneCode:
          contactInfoCountryPhoneCode ?? this.contactInfoCountryPhoneCode,
      contactInfoCountryAcronym:
          contactInfoCountryAcronym ?? this.contactInfoCountryAcronym,
      contactInfoPhoneNumberError:
          contactInfoPhoneNumberError ?? this.contactInfoPhoneNumberError,
      contactInfoPhoneNumber:
          contactInfoPhoneNumber ?? this.contactInfoPhoneNumber,
      contactInfoBrandName: contactInfoBrandName ?? this.contactInfoBrandName,
      contactInfoAboutBrand:
          contactInfoAboutBrand ?? this.contactInfoAboutBrand,
      contactInfoEmail: contactInfoEmail ?? this.contactInfoEmail,
      contactInfoEmailError:
          contactInfoEmailError ?? this.contactInfoEmailError,
      contactInfoAddress: contactInfoAddress ?? this.contactInfoAddress,
      fetchedPromotionType: fetchedPromotionType ?? this.fetchedPromotionType,
      colors: colors ?? this.colors,
      materials: materials ?? this.materials,
      sizes: sizes ?? this.sizes,
      earningValues: earningValues ?? this.earningValues,
      selectedTermsAndPolicy:
          selectedTermsAndPolicy ?? this.selectedTermsAndPolicy,
      fetchedCourierService:
          fetchedCourierService ?? this.fetchedCourierService,
    );
  }
}

//Secondary classes

final List<CommonType> dealTypeDropdownItems = [
  CommonType(id: "1", name: "An item"),
  CommonType(id: "2", name: "A service"),
  CommonType(id: "3", name: "A space/experience"),
];

final List<CommonType> listOfContinents = [
  CommonType(id: "1", name: "Asia"),
  CommonType(id: "2", name: "Africa"),
  CommonType(id: "3", name: "Europe"),
  CommonType(id: "4", name: "North America"),
  CommonType(id: "5", name: "South America"),
  CommonType(id: "6", name: "Australia/Oceania"),
  CommonType(id: "7", name: "Antarctica"),
];

final List<CommonType> regions = [
  CommonType(
    id: "1",
    name: "Local",
  ),
  CommonType(
    id: "2",
    name: "Worldwide",
  ),
];

class LocationSelection {
  final String? flag;
  final String? name;

  LocationSelection({this.flag, this.name});
}

class DocumentFile {
  String? title;
  String? name;
  File? doc;

  DocumentFile({
    this.title = "",
    this.name,
    this.doc,
  });
}

class NewDeailsDetailsVarient {
  List<File?>? images;
  String color;
  String size;
  String dimension;
  String material;
  String weight;

  NewDeailsDetailsVarient({
    required this.images,
    required this.color,
    required this.size,
    required this.dimension,
    required this.material,
    required this.weight,
  });
}
