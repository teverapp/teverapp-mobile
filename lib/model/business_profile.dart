import 'dart:io';

import 'package:tever/model/common.dart';
import 'package:tever/model/coordinate.dart';
import 'package:tever/model/country.dart';

class BusinessProfile {
  String businessName;
  String brandName;
  String? businessType;
  String? industry;
  Coordinate? address;
  CommonType tiktokUrl;
  CommonType twitterUrl;
  CommonType instagramUrl;
  CommonType threadsUrl;
  CommonType facebookUrl;
  String phoneNumber;
  Country? selectedPhoneNumberCountryDetails;
  String email;
  String aboutBusiness;
  bool phoneNumberHasError;
  bool emailHasError;
  File? businessLogo;

  BusinessProfile({
    required this.businessName,
    required this.brandName,
    required this.businessType,
    required this.industry,
    required this.address,
    required this.tiktokUrl,
    required this.twitterUrl,
    required this.instagramUrl,
    required this.threadsUrl,
    required this.facebookUrl,
    required this.phoneNumber,
    required this.selectedPhoneNumberCountryDetails,
    required this.email,
    required this.aboutBusiness,
    required this.phoneNumberHasError,
    required this.emailHasError,
    required this.businessLogo,
  });

  factory BusinessProfile.defaultState() {
    return BusinessProfile(
      businessName: "",
      brandName: "",
      businessType: null,
      industry: null,
      address: null,
      tiktokUrl: CommonType(name: ""),
      instagramUrl: CommonType(name: ""),
      facebookUrl: CommonType(name: ""),
      threadsUrl: CommonType(name: ""),
      twitterUrl: CommonType(name: ""),
      phoneNumber: "",
      selectedPhoneNumberCountryDetails: Country.defaultState(),
      email: "",
      aboutBusiness: "",
      phoneNumberHasError: true,
      emailHasError: true,
      businessLogo: null,
    );
  }

  BusinessProfile copyWith({
    String? businessName,
    String? brandName,
    String? businessType,
    String? industry,
    Coordinate? address,
    CommonType? tiktokUrl,
    CommonType? twitterUrl,
    CommonType? instagramUrl,
    CommonType? threadsUrl,
    CommonType? facebookUrl,
    String? phoneNumber,
    Country? selectedPhoneNumberCountryDetails,
    String? email,
    String? aboutBusiness,
    bool? phoneNumberHasError,
    bool? emailHasError,
    File? businessLogo,
  }) {
    return BusinessProfile(
      businessName: businessName ?? this.businessName,
      brandName: brandName ?? this.brandName,
      businessType: businessType ?? this.businessType,
      industry: industry ?? this.industry,
      address: address ?? this.address,
      tiktokUrl: tiktokUrl ?? this.tiktokUrl,
      twitterUrl: twitterUrl ?? this.twitterUrl,
      instagramUrl: instagramUrl ?? this.instagramUrl,
      threadsUrl: threadsUrl ?? this.threadsUrl,
      facebookUrl: facebookUrl ?? this.facebookUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      selectedPhoneNumberCountryDetails: selectedPhoneNumberCountryDetails ??
          this.selectedPhoneNumberCountryDetails,
      email: email ?? this.email,
      aboutBusiness: aboutBusiness ?? this.aboutBusiness,
      phoneNumberHasError: phoneNumberHasError ?? this.phoneNumberHasError,
      emailHasError: emailHasError ?? this.emailHasError,
      businessLogo: businessLogo ?? this.businessLogo,
    );
  }
}

final List<CommonType> businessTypes = [
  CommonType(
    id: "1",
    name: "Service based",
  ),
  CommonType(
    id: "2",
    name: "Product based",
  ),
];

final List<CommonType> industries = [
  CommonType(
    id: "1",
    name: "Technology",
  ),
  CommonType(
    id: "2",
    name: "Retail & E-commerce",
  ),
  CommonType(
    id: "3",
    name: "Professional Services",
  ),
  CommonType(
    id: "4",
    name: "Media & Entertainment",
  ),
  CommonType(
    id: "5",
    name: "Real Estate",
  ),
  CommonType(
    id: "6",
    name: "Finance & Investment",
  ),
  CommonType(
    id: "7",
    name: "Healthcare & Wellness",
  ),
  CommonType(
    id: "8",
    name: "Education & Training",
  ),
  CommonType(
    id: "9",
    name: "Logistics & Transportation",
  ),
  CommonType(
    id: "10",
    name: "Hospitality & Tourism",
  ),
];
