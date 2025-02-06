enum DealsTabStatus {
  hotDeals,
  services,
  items,
  events,
  spaces,
}

extension DealsTabStatusExtension on DealsTabStatus {
  String get value {
    switch (this) {
      case DealsTabStatus.hotDeals:
        return "Hot deals";
      case DealsTabStatus.services:
        return "Services";
      case DealsTabStatus.items:
        return "Items";
      case DealsTabStatus.events:
        return "Events";
      case DealsTabStatus.spaces:
        return "Spaces";
      default:
        return "";
    }
  }
}

enum DealsDropList {
  dealCategories,
  dealSubcategories,
  allCountries,
  country,
  state,
  spaceLocationState,
  shippingTo,
  shippingFrom,
  multipleSelection,
  promotionTypes,
  couriers,
  termsAndConditions,
}

extension DealsDropListExtension on DealsDropList {
  String get value {
    switch (this) {
      case DealsDropList.dealCategories:
        return "deal-categories";
      case DealsDropList.dealSubcategories:
        return "deal-subcategories";
      case DealsDropList.country:
        return "countries";
      case DealsDropList.allCountries:
        return "countries";
      case DealsDropList.state:
        return "states";
      case DealsDropList.spaceLocationState:
        return "spaceLocationState";
      case DealsDropList.promotionTypes:
        return "promotion-types";
      case DealsDropList.couriers:
        return "couriers";
      case DealsDropList.termsAndConditions:
        return "tnp";
      default:
        return "";
    }
  }
}
