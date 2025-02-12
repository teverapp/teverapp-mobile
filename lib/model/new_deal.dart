import 'dart:io';

import 'package:tever/model/common.dart';
import 'package:tever/model/coordinate.dart';

class NewDeal {
  int? id;
  CommonType? type;
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
  String? dealPromotionTypeId;
  String? dealPromotionValue;
  bool? isPromotionValueAPercentage;
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
  bool showShippingRateCard;
  CommonType? shippingRateCourierservice;
  List<LocationSelection>? selectedCountries;
  List<LocationSelection>? selectedStates;
  bool showAddPromotionMaterialCard;
  bool showAddAffliateMarketingCard;
  String? noOfRoomsForCleaning;
  String? duration;
  String? spaceLocationCountry;
  String? selectedCountryFromAllCountryId;
  Coordinate? spaceLocationAddress;
  String? spaceLocationCity;
  String? spaceLocationState;
  String? capacity;
  String? dimension;
  bool hasCreatedABussinessProfile;

  NewDeal({
    this.id,
    required this.isPromotionValueAPercentage,
    required this.hasCreatedABussinessProfile,
    required this.type,
    required this.colors,
    required this.sizes,
    required this.materials,
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
    required this.dealPromotionTypeId,
    required this.dealPromotionValue,
    required this.dealPromotionCode,
    required this.dealPromotionValidDate,
    required this.dealPromotionAffliateMarketingEarningValue,
    required this.requiredCustomerToInputCodeDuringCheckOut,
    required this.dealPromotionMaterialImage,
    required this.shippingFromCountry,
    required this.shippingToRegion,
    required this.shippingToCountry,
    required this.shippingToCountryId,
    required this.shippingToContinent,
    required this.shippingToContinentId,
    required this.showShippingRateCard,
    required this.shippingRateCourierservice,
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
    required this.earningValues,
    required this.selectedTermsAndPolicy,
  });

  factory NewDeal.defaultState() {
    return NewDeal(
      type: dealTypeDropdownItems[0],
      hasCreatedABussinessProfile: false,
      isPromotionValueAPercentage: false,
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
      dealPromotionTypeId: null,
      dealPromotionValue: "",
      dealPromotionCode: "",
      dealPromotionValidDate: null,
      dealPromotionAffliateMarketingEarningValue: null,
      requiredCustomerToInputCodeDuringCheckOut: false,
      dealPromotionMaterialImage: null,
      shippingFromCountry: null,
      shippingToRegion: null,
      shippingToCountry: null,
      shippingToCountryId: null,
      shippingToContinent: null,
      shippingToContinentId: null,
      showShippingRateCard: false,
      shippingRateCourierservice: CommonType(
        id: null,
        name: "",
        courierShippingRate: null,
        courierEstimatedTime: null,
      ),
      selectedCountries: [],
      selectedStates: [],
      showAddPromotionMaterialCard: false,
      showAddAffliateMarketingCard: false,
      noOfRoomsForCleaning: null,
      duration: null,
      spaceLocationCountry: null,
      selectedCountryFromAllCountryId: null,
      spaceLocationAddress: null,
      spaceLocationCity: "",
      spaceLocationState: null,
      capacity: "",
      dimension: "",
      selectedTermsAndPolicy: [],
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
    int? id,
    bool? isPromotionValueAPercentage,
    CommonType? type,
    List<CommonType>? allCountries,
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
    String? dealPromotionTypeId,
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
    String? shippingToContinent,
    String? shippingToContinentId,
    bool? showShippingRateCard,
    CommonType? shippingRateCourierservice,
    List<LocationSelection>? selectedCountries,
    List<LocationSelection>? selectedStates,
    bool? showAddPromotionMaterialCard,
    bool? showAddAffliateMarketingCard,
    String? noOfRoomsForCleaning,
    String? duration,
    String? spaceLocationCountry,
    String? selectedCountryFromAllCountryId,
    Coordinate? spaceLocationAddress,
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
    Coordinate? contactInfoAddress,
    List<CommonType>? colors,
    List<CommonType>? materials,
    List<CommonType>? sizes,
    List<CommonType>? earningValues,
    List<DocumentFile>? selectedTermsAndPolicy,
    bool? hasCreatedABussinessProfile,
  }) {
    return NewDeal(
      id: id ?? this.id,
      isPromotionValueAPercentage:
          isPromotionValueAPercentage ?? this.isPromotionValueAPercentage,
      type: type ?? this.type,
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
      dealPromotionTypeId: dealPromotionTypeId ?? this.dealPromotionTypeId,
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
      showShippingRateCard: showShippingRateCard ?? this.showShippingRateCard,
      shippingRateCourierservice:
          shippingRateCourierservice ?? this.shippingRateCourierservice,
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
      colors: colors ?? this.colors,
      materials: materials ?? this.materials,
      sizes: sizes ?? this.sizes,
      earningValues: earningValues ?? this.earningValues,
      selectedTermsAndPolicy:
          selectedTermsAndPolicy ?? this.selectedTermsAndPolicy,
      hasCreatedABussinessProfile:
          hasCreatedABussinessProfile ?? this.hasCreatedABussinessProfile,
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
  final String id;
  final String? flag;
  final String? name;

  LocationSelection({
    this.flag,
    this.name,
    required this.id,
  });
}

class DocumentFile {
  String? id;
  String? title;
  String? content;
  String? docName;
  File? doc;

  DocumentFile({
    this.title,
    this.content,
    this.doc,
    this.id,
    this.docName,
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
