import 'package:tever/model/business_profile.dart';

extension BusinessProfileUpdate on BusinessProfile {
  BusinessProfile update(String key, dynamic value) {
    switch (key) {
      case "businessName":
        return copyWith(businessName: value);
      case "brandName":
        return copyWith(brandName: value);
      case "address":
        return copyWith(address: value);
      case "businessType":
        return copyWith(businessType: value);
      case "industry":
        return copyWith(industry: value);
      case "tiktokUrl":
        return copyWith(tiktokUrl: value);
      case "twitterUrl":
        return copyWith(twitterUrl: value);
      case "instagramUrl":
        return copyWith(instagramUrl: value);
      case "threadsUrl":
        return copyWith(threadsUrl: value);
      case "facebookUrl":
        return copyWith(facebookUrl: value);
      case "phoneNumber":
        return copyWith(phoneNumber: value);
      case "selectedPhoneNumberCountryDetails":
        return copyWith(selectedPhoneNumberCountryDetails: value);
      case "email":
        return copyWith(email: value);
      case "aboutBusiness":
        return copyWith(aboutBusiness: value);
      case "phoneNumberHasError":
        return copyWith(phoneNumberHasError: value);
      case "emailHasError":
        return copyWith(emailHasError: value);
      case "businessLogo":
        return copyWith(businessLogo: value);

      default:
        throw Exception("Invalid key: $key");
    }
  }
}
