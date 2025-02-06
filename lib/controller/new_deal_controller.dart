import "dart:convert";
import "dart:io";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:tever/controller/access_token_controller.dart";
import "package:tever/controller/app_resource_controller.dart";
import "package:tever/controller/business_profile.dart";
import "package:tever/extensions/deals_tab.dart";
import "package:tever/extensions/new_deal_update.dart";
import "package:tever/helpers/general.dart";
import "package:tever/model/common.dart";
import "package:tever/model/custom_http_exception.dart";
import "package:tever/model/new_deal.dart";

class NewDealControllerNotifier extends StateNotifier<NewDeal> {
  NewDealControllerNotifier({required this.ref})
      : super(NewDeal.defaultState());
  final Ref ref;

  void updateNewDeal(String key, dynamic value) {
    state = state.update(key, value);
  }

  void uploadDealDetailsImages({required int imageIndex, required File image}) {
    final currentLength = state.dealDetailsImages?.length ?? 0;

    if (imageIndex < 0 || imageIndex >= currentLength) {
      throw IndexError.withLength(
        imageIndex,
        currentLength,
        indexable: state.dealDetailsImages,
        name: 'imageIndex',
        message: 'Invalid index for dealDetailsImages list',
      );
    }

    final updatedImages = state.dealDetailsImages!;

    updatedImages[imageIndex] = image;

    state = state.copyWith(dealDetailsImages: updatedImages);
  }

  void addToSelectedCountry({required LocationSelection country}) {
    final updatedCountries = [...state.selectedCountries!, country];

    state = state.copyWith(selectedCountries: updatedCountries);
  }

  void updateColors({required CommonType color}) {
    final updatedColors = [...state.colors, color];

    state = state.copyWith(colors: updatedColors);
  }

  void updateMaterials({required CommonType material}) {
    final updatedmaterials = [...state.materials, material];

    state = state.copyWith(materials: updatedmaterials);
  }

  void updateSizes({required CommonType size}) {
    final updatedSizes = [...state.sizes, size];

    state = state.copyWith(sizes: updatedSizes);
  }

  void updateEarningValues({required CommonType earningValue}) {
    final updatedEarningValues = [...state.earningValues, earningValue];

    state = state.copyWith(earningValues: updatedEarningValues);
  }

  void removeFromSelectedCountry({required int index}) {
    // Safely create a copy of selectedCountries
    final updatedCountries = state.selectedCountries;

    // Ensure the index is within bounds
    if (index >= 0 && index < updatedCountries!.length) {
      updatedCountries.removeAt(index);
    }

    // Update the correct field in the state
    state = state.copyWith(selectedCountries: updatedCountries);

    // Debugging output
    print("Updated selectedCountries: ${state.selectedCountries}");
  }

  void addSelectedStates({required LocationSelection selectedState}) {
    final updatedStates = [...state.selectedStates!, selectedState];

    state = state.copyWith(selectedStates: updatedStates);
  }

  void resetSelectedStatedAndCountry() {
    ref.read(appResourceProvider.notifier).resetFetchedStates();

    ref.read(appResourceProvider.notifier).resetFetchedCountries();

    print("reset callled");
    state = state.copyWith(
        selectedCountries: [],
        selectedStates: [],
        shippingToCountry: null,
        shippingToContinent: null);
  }

  void resetSelectedStateDetails() {
    ref.read(appResourceProvider.notifier).resetFetchedStates();

    state = state.copyWith(
        selectedCountries: [],
        selectedStates: [],
        shippingToCountry: null,
        shippingToContinent: null);
  }

  void resetSpaceLocationSelectedState() {
    ref.read(appResourceProvider.notifier).resetFetchedStates();

    state = state.copyWith(spaceLocationState: null);
  }

  void removeFromSelectedState({required int index}) {
    // Safely copy selectedStates
    final updatedStates = state.selectedStates;

    if (index < 0 || index >= updatedStates!.length) {
      print("Index out of bounds: $index");
      return;
    }

    // Remove item
    print("Removing index $index from selectedStates");
    updatedStates.removeAt(index);

    // Update state
    state = state.copyWith(selectedStates: updatedStates);
    print("Updated selectedStates: ${state.selectedStates}");
  }

  void addVarient({required NewDeailsDetailsVarient varient}) {
    final updatedVarients = [...state.varient, varient];

    state = state.copyWith(varient: updatedVarients);
  }

  void updateVarient({
    required int variantIndex,
    required NewDeailsDetailsVarient varient,
  }) {
    final currentLength = state.varient.length + 1;

    if (variantIndex < 0 || variantIndex > currentLength) {
      final updatedVarient = List<NewDeailsDetailsVarient>.from(state.varient);

      updatedVarient.add(varient);

      state = state.copyWith(varient: updatedVarient);
      return;
    }

    final updatedVarient = List<NewDeailsDetailsVarient>.from(state.varient);
    updatedVarient[variantIndex] = varient;

    state = state.copyWith(varient: updatedVarient);
  }

  void updateCourierServiceRate(String rate) {
    final CommonType? shippingRateCourierservice =
        state.shippingRateCourierservice;

    shippingRateCourierservice!.courierShippingRate = rate;

    state =
        state.copyWith(shippingRateCourierservice: shippingRateCourierservice);
  }

  void updateTermsAndPolicy({
    required DocumentFile termsAndPolicy,
  }) {
    final updatedSelectedTermsAndPolicy =
        List<DocumentFile>.from(state.selectedTermsAndPolicy);

    final existingIndex = updatedSelectedTermsAndPolicy.indexWhere(
      (file) => file.title == termsAndPolicy.title,
    );

    if (existingIndex != -1) {
      print("updateTermsAndPolicy yes");
      termsAndPolicy.title = updatedSelectedTermsAndPolicy[existingIndex].title;

      updatedSelectedTermsAndPolicy[existingIndex] = termsAndPolicy;
    } else {
      print("updateTermsAndPolicy no");
      updatedSelectedTermsAndPolicy.add(termsAndPolicy);
    }

    state =
        state.copyWith(selectedTermsAndPolicy: updatedSelectedTermsAndPolicy);
    print(
        "updatedSelectedTermsAndPolicy Length ${updatedSelectedTermsAndPolicy.length}");
    return;
  }

  // void updateTermsAndPolicy({
  //   required DocumentFile termsAndPolicy,
  // }) {
  //   DocumentFile? updatedSelectedTermsAndPolicy = state.selectedTermsAndPolicy;

  //   updatedSelectedTermsAndPolicy?.doc =
  //       termsAndPolicy.doc ?? state.selectedTermsAndPolicy?.doc;
  //   updatedSelectedTermsAndPolicy?.docName =
  //       termsAndPolicy.docName ?? state.selectedTermsAndPolicy?.docName;
  //   updatedSelectedTermsAndPolicy?.content =
  //       termsAndPolicy.content ?? state.selectedTermsAndPolicy?.content;
  //   updatedSelectedTermsAndPolicy?.id =
  //       termsAndPolicy.id ?? state.selectedTermsAndPolicy?.id;
  //   updatedSelectedTermsAndPolicy?.title =
  //       termsAndPolicy.title ?? state.selectedTermsAndPolicy?.title;

  //   print("neeeeeewolaad--< ${updatedSelectedTermsAndPolicy?.id}");
  //   state =
  //       state.copyWith(selectedTermsAndPolicy: updatedSelectedTermsAndPolicy);
  // }

  void deleteTermsAndPolicy({
    required String title,
  }) {
    final updatedSelectedTermsAndPolicy =
        List<DocumentFile>.from(state.selectedTermsAndPolicy);

    final existingIndex = updatedSelectedTermsAndPolicy.indexWhere(
      (file) => file.title == title,
    );

    updatedSelectedTermsAndPolicy.removeAt(existingIndex);

    state =
        state.copyWith(selectedTermsAndPolicy: updatedSelectedTermsAndPolicy);

    print(
        "updatedSelectedTermsAndPolicy ${updatedSelectedTermsAndPolicy.length}");
  }

  void updateField(String key, dynamic value) {
    state = state.update(key, value);
  }

  Future<void> uploadDeal({required bool saveToDraft}) async {
    final url = Uri.parse('$baseUrl/deals/create-edit');

    final creatingBusinessProfile = ref.watch(businessProfileProvider);
    final token = ref.watch(accessTokenProvider);

    // Create the multipart request
    final request = http.MultipartRequest('POST', url);

    // Attach the token as an Authorization header
    request.headers['Authorization'] = 'Bearer $token';

    // Add text fields
    request.fields['action'] = "c";
    request.fields['dealTypeId'] = state.type!.id.toString();
    request.fields['title'] = state.title.toString();
    request.fields['categoryId'] = state.categoryId.toString();
    request.fields['subCategoryId'] =
        state.subCategoryId ?? state.subCategory.toString();
    request.fields['description'] = state.description.toString();
    request.fields['isDraft'] = saveToDraft ? "true" : "false";
    request.fields['dealLong'] =
        creatingBusinessProfile.address!.locationLongitude.toString();
    request.fields['dealLat'] =
        creatingBusinessProfile.address!.locationLatiude.toString();
    request.fields['shippingToRegion'] = state.shippingToRegion.toString();

    if (!state.contactForQuote) {
      request.fields['price'] = state.price!;
    }

    // Add deal details array (variants)
    if (state.varient.isNotEmpty) {
      // Build a list of variant objects.
      final variants = state.varient.map((variant) {
        final Map<String, dynamic> variantData = {
          "color": variant.color,
          "size": variant.size,
          "dimension": variant.dimension,
          "material": variant.material,
          "weight": variant.weight,
        };

        // Filter out null images and add their file names
        final imagePaths = variant.images
            ?.where((image) => image != null)
            .map((image) => image!.path)
            .toList();

        if (imagePaths != null && imagePaths.isNotEmpty) {
          variantData["variantImages"] = imagePaths;
        }
        return variantData;
      }).toList();

      request.fields['dealDetails'] = jsonEncode(variants);
    }

    // Add shipping details as JSON text
    request.fields['dealShippingDetails'] = jsonEncode({
      "shippingFromCountryIds": [
        if (state.shippingFromCountryId != null) state.shippingFromCountryId
      ],
      "shippingType": state.shippingToRegion,
      "shippingToContinentIds": [
        if (state.shippingToContinentId != null) state.shippingToContinentId
      ],
      "dealShippingToCountryIds": [
        if (state.shippingToContinentId != null) state.shippingToContinentId,
        ...state.selectedStates?.map((e) => e.id).toList() ?? []
      ],
      "shippingToStates": [
        if (state.shippingToCountryId != null) state.shippingToCountryId,
        ...state.selectedCountries?.map((e) => e.id).toList() ?? []
      ],
      if (state.showShippingRateCard)
        "rate": {
          "courierId": state.shippingRateCourierservice!.id,
          "rate":
              state.shippingRateCourierservice!.courierShippingRate as double,
        }
    });

    // Combine promotion details (example: merge promotion and business profile)
    final promotionData = {
      "promotionTypeId": state.dealPromotionTypeId,
      "promotionCode": state.dealPromotionCode,
      "promotionValue": state.dealPromotionValue,
      "expiryDate": state.dealPromotionValidDate,
      // If you want to send the promotional material as a file, it will be added separately.
      "requireCheckoutInput": state.requiredCustomerToInputCodeDuringCheckOut,
      // Add business profile details:
    };
    request.fields['dealPromotion'] = jsonEncode(promotionData);

    final dealContact = {
      "brandName": creatingBusinessProfile.brandName,
      "about": creatingBusinessProfile.aboutBusiness,
      "contactEmail": creatingBusinessProfile.email,
      "address": creatingBusinessProfile.address!.locationName,
      "longtude": creatingBusinessProfile.address!.locationLongitude,
      "latutude": creatingBusinessProfile.address!.locationLatiude,
      "contactPhone": creatingBusinessProfile.phoneNumber,
      "countryCode":
          creatingBusinessProfile.selectedPhoneNumberCountryDetails!.phoneCode,
    };

    request.fields['dealContact'] = jsonEncode(dealContact);

    // Add deal terms and conditions
    if (state.selectedTermsAndPolicy.isNotEmpty) {
      final termsAndConditions = state.selectedTermsAndPolicy.map((doc) {
        return {
          "typeId": doc.id,
          "rawContent": doc.content,
          "rawContentFile":
              doc.doc != null ? doc.doc!.path.split('/').last : null,
        };
      }).toList();

      request.fields['dealTnC'] = jsonEncode(termsAndConditions);
    }

    // ----------------------------
    // Attach file uploads below.
    // ----------------------------

    // 1. Deal Images (from dealDetailsImages)
    if (state.dealDetailsImages != null) {
      final nonNullImages =
          state.dealDetailsImages!.where((file) => file != null).toList();

      for (int i = 0; i < nonNullImages.length; i++) {
        final file = nonNullImages[i]!;
        if (file.existsSync()) {
          final stream = http.ByteStream(file.openRead());
          final length = await file.length();
          final multipartFile = http.MultipartFile(
            // Use a field name your backend expects. For an array, you may use "dealImages[]" or repeat "dealImages".
            'dealImages[$i]',
            stream,
            length,
            filename: file.path.split('/').last,
          );
          request.files.add(multipartFile);
        }
      }
    }

    // 2. Promotional Material Image (if available)
    if (state.dealPromotionMaterialImage != null &&
        state.dealPromotionMaterialImage!.existsSync()) {
      final file = state.dealPromotionMaterialImage!;
      final stream = http.ByteStream(file.openRead());
      final length = await file.length();
      final multipartFile = http.MultipartFile(
        'promotionalMaterial', // backend field name for the promotion image
        stream,
        length,
        filename: file.path.split('/').last,
      );
      request.files.add(multipartFile);
    }

    // 3. Attach terms and conditions documents
    for (final doc in state.selectedTermsAndPolicy) {
      if (doc.doc != null && doc.doc!.existsSync()) {
        final file = doc.doc!;
        final stream = http.ByteStream(file.openRead());
        final length = await file.length();
        final multipartFile = http.MultipartFile(
          'dealTnCFiles', // backend field name for the terms and conditions files
          stream,
          length,
          filename: file.path.split('/').last,
        );
        request.files.add(multipartFile);
      }
    }

    // Print form fields and file info for debugging

    print('Form fields: ${request.fields}');
    print('Attached files: ${request.files.map((f) => f.filename).toList()}');

    return;
    try {
      // Send the request
      final response = await request.send();
      final responseData = await response.stream.bytesToString();

      // Check if the response is non-empty before decoding
      if (responseData.isNotEmpty) {
        try {
          final decodedResponse = jsonDecode(responseData);
          print('Response data: $decodedResponse');

          if (response.statusCode == 200) {
            print('Upload successful: $decodedResponse');
          } else {
            print('Failed to upload. Status code: ${response.statusCode}');
            print('Error details: $decodedResponse');
          }
        } catch (e) {
          print('Error decoding response: $e');
          print('Raw response: $responseData');
        }
      } else {
        print('Received empty response');
      }
    } catch (e) {
      print('Error uploading deal: $e');
    }
  }

  // Future<void> uploadDeal({required bool saveToDraft}) async {
  //   final url = Uri.parse('$baseUrl/deals/create-edit');

  //   final creatingBusinessProfile = ref.watch(businessProfileProvider);

  //   final request = http.MultipartRequest('POST', url);

  //   // Add fields
  //   request.fields['action'] = "c";
  //   request.fields['dealTypeId'] = state.type!.id.toString();
  //   request.fields['title'] = state.title.toString();
  //   request.fields['categoryId'] = state.categoryId.toString();
  //   request.fields['subCategoryId'] =
  //       state.subCategoryId ?? state.subCategory.toString();
  //   request.fields['description'] = state.description.toString();
  //   request.fields['isDraft'] = saveToDraft ? "true" : "false";

  //   request.fields['dealLong'] =
  //       creatingBusinessProfile.address!.locationLongitude.toString();
  //   request.fields['dealLat'] =
  //       creatingBusinessProfile.address!.locationLatiude.toString();
  //   request.fields['shippingToRegion'] = state.shippingToRegion.toString();
  //   //  request.fields['UserId'] = userId;
  //   // request.fields['IsFeatured'] = isFeatured.toString();
  //   // request.fields['IsPremium'] = isPremium.toString();
  //   // request.fields['IsTeverPick'] = isTeverPick.toString();
  //   // request.fields['HasPromotion'] = hasPromotion.toString();
  //   if (!state.contactForQuote) request.fields['price'] = state.price!;
  //   //  request.fields['IsBarter'] = isBarter.toString();
  //   //  request.fields['CurrencyName'] = currencyName;
  //   // request.fields['CurrencyId'] = currencyId.toString();
  //   //  request.fields['PricingType'] = pricingType.toString();
  //   // request.fields['PriceIndicator'] = priceIndicator;

  //   // Add arrays
  //   if (state.varient.isNotEmpty) {
  //     request.fields['dealDetails'] = jsonEncode(state.varient.map((varient) {
  //       final Map<String, dynamic> variantData = {
  //         "color": varient.color,
  //         "size": varient.size,
  //         "dimension": varient.dimension,
  //         "material": varient.material,
  //         "weight": varient.weight,
  //       };

  //       // Filter out null images before adding "VariantImages"
  //       List<String> imagePaths = varient.images
  //               ?.where((image) => image != null) // Remove null images
  //               .map((image) => image!.path) // Get image paths
  //               .toList() ??
  //           [];

  //       // Only add "VariantImages" if there are valid image paths
  //       if (imagePaths.isNotEmpty) {
  //         variantData["variantImages"] = imagePaths;
  //       }

  //       return variantData;
  //     }).toList());
  //   }

  //   request.fields['dealShippingDetails'] = jsonEncode({
  //     "shippingFromCountryIds": [state.shippingFromCountryId],
  //     "shippingType": state.shippingToRegion,
  //     "shippingToContinentIds": [state.shippingToContinentId],
  //     "dealShippingToCountryIds": [
  //       if (state.shippingToContinentId != null) state.shippingToContinentId,
  //       ...state.selectedStates?.map((e) => e.id).toList() ?? []
  //     ],
  //     "shippingToStates": [
  //       if (state.shippingToCountryId != null) state.shippingToCountryId,
  //       ...state.selectedCountries?.map((e) => e.id).toList() ?? []
  //     ],
  //     // "shippingToCities": [
  //     //   "string"
  //     // ],
  //     if (state.showShippingRateCard)
  //       "rate": {
  //         "courierId": state.shippingRateCourierservice!.id,
  //         "rate":
  //             state.shippingRateCourierservice!.courierShippingRate as double,
  //         // "rateInWords": "string",
  //         // "currencyId": 0,
  //         // "eta": "string"
  //       }
  //   });

  //   request.fields['dealPromotion'] = jsonEncode(
  //     {
  //       "promotionTypeId": state.dealPromotionTypeId,
  //       "promotionCode": state.dealPromotionCode,
  //       "promotionValue": state.dealPromotionValue,
  //       // "isPercentage": true,
  //       // "startDate": "2025-02-04T07:42:55.321Z",
  //       "expiryDate": state.dealPromotionValidDate,
  //       "promotionalMaterial": state.dealPromotionMaterialImage,
  //       "requireCheckoutInput": state.requiredCustomerToInputCodeDuringCheckOut,
  //       // "requireCheckoutInput": true,
  //       // "hasPromotionalMaterial": true,
  //       // "isForFree": true,
  //       // "isForFreeShipping": true,
  //       // "allowAffiliate": true,
  //       // "affiliatePercent": 0
  //     },
  //   );

  //   request.fields['dealPromotion'] = jsonEncode(
  //     {
  //       "brandName": creatingBusinessProfile.brandName,
  //       "about": creatingBusinessProfile.aboutBusiness,
  //       "contactEmail": creatingBusinessProfile.email,
  //       "address": creatingBusinessProfile.address!.locationName,
  //       "longtude": creatingBusinessProfile.address!.locationLongitude,
  //       "latutude": creatingBusinessProfile.address!.locationLatiude,
  //       "contactPhone": creatingBusinessProfile.phoneNumber,
  //       "countryCode":
  //           creatingBusinessProfile.selectedPhoneNumberCountryDetails!.phoneCode
  //     },
  //   );

  //   final nonNullDealDetailsImages = state.dealDetailsImages
  //           ?.where((image) => image != null)
  //           .map((image) => image!.path)
  //           .toList() ??
  //       [];

  //   request.fields['dealImages'] = jsonEncode(nonNullDealDetailsImages);

  //   request.fields['dealTnC'] = jsonEncode(
  //     {
  //       "typeId": state.selectedTermsAndPolicy!.id.toString(),
  //       "rawFile": state.selectedTermsAndPolicy!.doc,
  //       "rawContent": state.selectedTermsAndPolicy!.content
  //     },
  //   );
  //   // // Add nested objects
  //   // if (dealPromotion != null) {
  //   //   request.fields['DealPromotion'] = jsonEncode(dealPromotion);
  //   // }
  //   // if (dealContact != null) {
  //   //   request.fields['DealContact'] = jsonEncode(dealContact);
  //   // }

  //   // //Add image files
  //   // if (coverImage.existsSync()) {
  //   //   final coverImageStream = http.ByteStream(coverImage.openRead());
  //   //   final coverImageLength = await coverImage.length();
  //   //   final coverImageMultipart = http.MultipartFile(
  //   //     'CoverImage',
  //   //     coverImageStream,
  //   //     coverImageLength,
  //   //     filename: coverImage.path.split('/').last,
  //   //   );
  //   //   request.files.add(coverImageMultipart);
  //   // }

  //   // if (dealImages != null) {
  //   //   for (int i = 0; i < dealImages.length; i++) {
  //   //     final image = dealImages[i];
  //   //     if (image.existsSync()) {
  //   //       final imageStream = http.ByteStream(image.openRead());
  //   //       final imageLength = await image.length();
  //   //       final imageMultipart = http.MultipartFile(
  //   //         'DealImages.ImageFile[$i]',
  //   //         imageStream,
  //   //         imageLength,
  //   //         filename: image.path.split('/').last,
  //   //       );
  //   //       request.files.add(imageMultipart);
  //   //     }
  //   //   }
  //   // }

  //   //Add optional DealId
  //   // if (dealId != null) {
  //   //   request.fields['DealId'] = dealId.toString();
  //   // }

  //   try {
  //     print('Form fields: ${request.fields}');

  //     final response = await request.send();

  //     // Read the response as a string
  //     final responseData = await response.stream.bytesToString();

  //     // Check if the response is not empty
  //     if (responseData.isNotEmpty) {
  //       final decodedResponse = jsonDecode(responseData);
  //       print('Response data: $decodedResponse');

  //       if (response.statusCode == 200) {
  //         print('Upload successful: $decodedResponse');
  //       } else {
  //         print('Failed to upload. Status code: ${response.statusCode}');
  //         print('Error details: $decodedResponse');
  //       }
  //     } else {
  //       print('Received empty response');
  //     }
  //   } catch (e) {
  //     print('Error uploading deal: $e');
  //   }
  // }
}

final newDealDataProvider =
    StateNotifierProvider<NewDealControllerNotifier, NewDeal>((ref) {
  return NewDealControllerNotifier(ref: ref);
});

// void updateField(String key, dynamic value) {
//   state = state.update(key, value);
// }

// Future<void> uploadDeal({
//   required String action,
//   required int dealTypeId,
//   required String title,
//   required int categoryId,
//   required int subCategoryId,
//   required String description,
//   required File coverImage,
//   required bool isDraft,
//   required double dealLong,
//   required double dealLat,
//   required int shippingId,
//   required String userId,
//   required bool isFeatured,
//   required bool isPremium,
//   required bool isTeverPick,
//   required bool hasPromotion,
//   required double price,
//   required bool isBarter,
//   required String currencyName,
//   required int currencyId,
//   required int pricingType,
//   required String priceIndicator,
//   required List<Map<String, dynamic>> dealDetails,
//   required List<Map<String, dynamic>> dealShippingDetails,
//   Map<String, dynamic>? dealPromotion,
//   Map<String, dynamic>? dealContact,
//   List<File>? dealImages,
//   List<String>? dealTnC,
//   int? dealId,
// }) async {
//   final url = Uri.parse(
//       'https://example.com/api/deal'); // Replace with your backend URL

//   // Prepare multipart request
//   final request = http.MultipartRequest('POST', url);

//   // Add fields
//   request.fields['Action'] = action;
//   request.fields['DealTypeId'] = dealTypeId.toString();
//   request.fields['Title'] = title;
//   request.fields['CategoryId'] = categoryId.toString();
//   request.fields['SubCategoryId'] = subCategoryId.toString();
//   request.fields['Description'] = description;
//   request.fields['IsDraft'] = isDraft.toString();
//   request.fields['DealLong'] = dealLong.toString();
//   request.fields['DealLat'] = dealLat.toString();
//   request.fields['ShippingId'] = shippingId.toString();
//   request.fields['UserId'] = userId;
//   request.fields['IsFeatured'] = isFeatured.toString();
//   request.fields['IsPremium'] = isPremium.toString();
//   request.fields['IsTeverPick'] = isTeverPick.toString();
//   request.fields['HasPromotion'] = hasPromotion.toString();
//   request.fields['Price'] = price.toString();
//   request.fields['IsBarter'] = isBarter.toString();
//   request.fields['CurrencyName'] = currencyName;
//   request.fields['CurrencyId'] = currencyId.toString();
//   request.fields['PricingType'] = pricingType.toString();
//   request.fields['PriceIndicator'] = priceIndicator;

//   // Add arrays
//   request.fields['DealDetails'] = jsonEncode(dealDetails);
//   request.fields['DealShippingDetails'] = jsonEncode(dealShippingDetails);
//   if (dealTnC != null) {
//     request.fields['DealTnC'] = jsonEncode(dealTnC);
//   }

//   // Add nested objects
//   if (dealPromotion != null) {
//     request.fields['DealPromotion'] = jsonEncode(dealPromotion);
//   }
//   if (dealContact != null) {
//     request.fields['DealContact'] = jsonEncode(dealContact);
//   }

//   // Add image files
//   if (coverImage.existsSync()) {
//     final coverImageStream = http.ByteStream(coverImage.openRead());
//     final coverImageLength = await coverImage.length();
//     final coverImageMultipart = http.MultipartFile(
//       'CoverImage',
//       coverImageStream,
//       coverImageLength,
//       filename: coverImage.path.split('/').last,
//     );
//     request.files.add(coverImageMultipart);
//   }

//   if (dealImages != null) {
//     for (int i = 0; i < dealImages.length; i++) {
//       final image = dealImages[i];
//       if (image.existsSync()) {
//         final imageStream = http.ByteStream(image.openRead());
//         final imageLength = await image.length();
//         final imageMultipart = http.MultipartFile(
//           'DealImages.ImageFile[$i]',
//           imageStream,
//           imageLength,
//           filename: image.path.split('/').last,
//         );
//         request.files.add(imageMultipart);
//       }
//     }
//   }

//   // Add optional DealId
//   if (dealId != null) {
//     request.fields['DealId'] = dealId.toString();
//   }

//   try {
//     // Send request
//     final response = await request.send();

//     // Handle response
//     if (response.statusCode == 200) {
//       final responseData = await response.stream.bytesToString();
//       print('Upload successful: $responseData');
//     } else {
//       print('Failed to upload: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error uploading deal: $e');
//   }
// }

