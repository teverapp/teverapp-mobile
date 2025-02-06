import 'package:tever/model/new_deal.dart';

extension NewDealUpdate on NewDeal {
  NewDeal update(String key, dynamic value) {
    switch (key) {
      case 'type':
        return copyWith(type: value);
      case "categoryId":
        return copyWith(categoryId: value);
      case "subCategoryId":
        return copyWith(subCategoryId: value);
      case "category":
        return copyWith(category: value);
      case "subCategory":
        return copyWith(subCategory: value);
      case 'title':
        return copyWith(title: value);
      case "description":
        return copyWith(description: value);
      case "price":
        return copyWith(price: value);
      case "contactForQuote":
        return copyWith(contactForQuote: value);
      case "showAddAVarientBtn":
        return copyWith(showAddAVarientBtn: value);
      case "dealPromotionType":
        return copyWith(dealPromotionType: value);
      case "dealPromotionTypeId":
        return copyWith(dealPromotionTypeId: value);
      case "dealPromotionValue":
        return copyWith(dealPromotionValue: value);
      case "dealPromotionCode":
        return copyWith(dealPromotionCode: value);
      case "dealPromotionValidDate":
        return copyWith(dealPromotionValidDate: value);
      case "dpamev":
        return copyWith(dealPromotionAffliateMarketingEarningValue: value);
      case "requiredCustomerToInputCodeDuringCheckOut":
        return copyWith(requiredCustomerToInputCodeDuringCheckOut: value);
      case "dpmi":
        return copyWith(dealPromotionMaterialImage: value);
      case "shippingFromCountry":
        return copyWith(shippingFromCountry: value);
      case "shippingToRegion":
        return copyWith(shippingToRegion: value);
      case "shippingToCountry":
        return copyWith(shippingToCountry: value);
      case "shippingToCountryId":
        return copyWith(shippingToCountryId: value);
      case "shippingToContinent":
        return copyWith(shippingToContinent: value);
      case "shippingToContinentId":
        return copyWith(shippingToContinentId: value);
      // case "shippingToCity":
      //   return copyWith(shippingToCity: value);
      case "showShippingRateCard":
        return copyWith(showShippingRateCard: value);
      case "shippingRateCourierservice":
        return copyWith(shippingRateCourierservice: value);
      // case "shippingRate":
      //   return copyWith(shippingRate: value);
      // case "shippingRateEstimatedDeliveryTime":
      //   return copyWith(shippingRateEstimatedDeliveryTime: value);
      case "showAddPromotionMaterialCard":
        return copyWith(showAddPromotionMaterialCard: value);
      case "showAddAffliateMarketingCard":
        return copyWith(showAddAffliateMarketingCard: value);
      case "noOfRoomsForCleaning":
        return copyWith(noOfRoomsForCleaning: value);
      case "duration":
        return copyWith(duration: value);
      case "spaceLocationCountry":
        return copyWith(spaceLocationCountry: value);
      case "spaceLocationAddress":
        return copyWith(spaceLocationAddress: value);
      case "spaceLocationCity":
        return copyWith(spaceLocationCity: value);
      case "spaceLocationState":
        return copyWith(spaceLocationState: value);
      case "capacity":
        return copyWith(capacity: value);
      case "dimension":
        return copyWith(dimension: value);
      case "selectedCountryFromAllCountryId":
        return copyWith(selectedCountryFromAllCountryId: value);
      case "contactInfoCountryFlag":
        return copyWith(contactInfoCountryFlag: value);
      case "contactInfoCountryPhoneCode":
        return copyWith(contactInfoCountryPhoneCode: value);
      case "contactInfoCountryAcronym":
        return copyWith(contactInfoCountryAcronym: value);

      case "contactInfoPhoneNumberError":
        return copyWith(contactInfoPhoneNumberError: value);
      case "contactInfoPhoneNumber":
        return copyWith(contactInfoPhoneNumber: value);
      case "contactInfoBrandName":
        return copyWith(contactInfoBrandName: value);
      case "contactInfoAboutBrand":
        return copyWith(contactInfoAboutBrand: value);
      case "contactInfoEmail":
        return copyWith(contactInfoEmail: value);
      case "contactInfoEmailError":
        return copyWith(contactInfoEmailError: value);
      case "contactInfoAddress":
        return copyWith(contactInfoAddress: value);
      case "hasCreatedABussinessProfile":
        return copyWith(hasCreatedABussinessProfile: value);
      default:
        throw Exception("Invalid key: $key");
    }
  }
}
