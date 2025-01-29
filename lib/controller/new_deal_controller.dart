import "dart:convert";
import "dart:io";

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:tever/controller/access_token_controller.dart";
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

  void addToSubCategoryList({required CommonType subCat}) {
    final updatedSubCatgory = [...state.dealDetailsSubCategory, subCat];

    state = state.copyWith(dealDetailsSubCategory: updatedSubCatgory);
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
    print("reset callled");
    state = state.copyWith(
        selectedCountries: [],
        selectedStates: [],
        countries: [],
        fetchedStates: [],
        shippingToCountry: null,
        shippingToContinent: null);
  }

  void resetSelectedStateDetails() {
    print("reset callled");
    state = state.copyWith(
        selectedCountries: [],
        selectedStates: [],
        fetchedStates: [],
        shippingToCountry: null,
        shippingToContinent: null);
  }

  void resetSpaceLocationSelectedState() {
    print("reset callled");
    state = state.copyWith(spaceLocationState: null, fetchedStates: []);
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
  }

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
  }

  void deleteTermsAndPolicyFile({
    required String title,
  }) {
    final updatedSelectedTermsAndPolicy =
        List<DocumentFile>.from(state.selectedTermsAndPolicy);

    final existingIndex = updatedSelectedTermsAndPolicy.indexWhere(
      (file) => file.title == title,
    );
    updatedSelectedTermsAndPolicy[existingIndex].name = null;

    updatedSelectedTermsAndPolicy[existingIndex].doc = null;

    state =
        state.copyWith(selectedTermsAndPolicy: updatedSelectedTermsAndPolicy);
  }

  Future<void> fetchResources(
      {required String type, bool fetchItemWithId = false}) async {
    print("fetchNewDealDetailsCategory called");

    final queryParam = type;

    // final queryParam = type == DealsDropList.dealCategories.value
    //     ? DealsDropList.dealCategories.value
    //     : type == DealsDropList.dealSubcategories.value
    //         ? DealsDropList.dealSubcategories.value
    //         : type == DealsDropList.country.value
    //             ? DealsDropList.country.value
    //             : (type == DealsDropList.state.value ||
    //                     type == DealsDropList.spaceLocationState.value)
    //                 ? DealsDropList.state.value
    //                 : type == DealsDropList.promotionTypes.value
    //             ? DealsDropList.country.value
    //             :"";

    final resourceId = type == DealsDropList.country.value
        ? state.shippingToContinentId
        : type == DealsDropList.state.value
            ? state.shippingToCountryId
            : type == DealsDropList.spaceLocationState.value
                ? state.selectedCountryFromAllCountryId
                : type == DealsDropList.dealSubcategories.value
                    ? state.categoryId
                    : "";

    final url =
        Uri.parse("$baseUrl/util/resource/get").replace(queryParameters: {
      "Page": "1",
      "Limit": "2",
      "Download": "true",
      if (fetchItemWithId) "ResourceId": resourceId,
      "Resource": queryParam,
    });

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );

      final responseData = jsonDecode(response.body);
      print(
          "Response Data: Resource: $queryParam ResourceId: $resourceId body => $responseData");
      if (response.statusCode == 200) {
        final List<dynamic> categoriesData = responseData['data'] ?? [];

        final List<CommonType> fetchedResources =
            categoriesData.map((item) => CommonType.fromJson(item)).toList();

        state = state.copyWith(
          fetchedCourierService: type == DealsDropList.couriers.value
              ? fetchedResources
              : state.dealDetailsCategory,
          fetchedPromotionType: type == DealsDropList.promotionTypes.value
              ? fetchedResources
              : state.dealDetailsCategory,
          fetchedStates: (type == DealsDropList.state.value ||
                  type == DealsDropList.spaceLocationState.value)
              ? fetchedResources
              : state.fetchedStates,
          countries: type == DealsDropList.country.value
              ? fetchedResources
              : state.countries,
          dealDetailsSubCategory: type == DealsDropList.dealSubcategories.value
              ? fetchedResources
              : state.dealDetailsSubCategory,
          dealDetailsCategory: type == DealsDropList.dealCategories.value
              ? fetchedResources
              : state.dealDetailsCategory,
        );

        print("Updated State: ${state.dealDetailsCategory}");

        return;
      }

      final errorMessage =
          responseData['error']?['message'] ?? "Unknown error occurred";
      throw CustomHttpException(errorMessage);
    } catch (error) {
      print("Error fetching deal categories: ${error.toString()}");
      rethrow;
    }
  }

  Future<void> fetchNewDealPromotionType() async {
    final url =
        Uri.parse("$baseUrl/util/resource/get").replace(queryParameters: {
      "Page": "1",
      "Limit": "22",
      "Resource": "promotion-types",
    });

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );

      final responseData = jsonDecode(response.body);
      print("Response Data: $responseData");

      if (response.statusCode == 200) {
        final List<dynamic> categoriesData = responseData['data'] ?? [];

        final List<CommonType> fetchedPromotionTypes =
            categoriesData.map((item) => CommonType.fromJson(item)).toList();

        state = state.copyWith(
          fetchedPromotionType: fetchedPromotionTypes,
        );

        print("Updated State: ${state.dealDetailsCategory}");
        return;
      }

      // Handle error case
      final errorMessage =
          responseData['error']?['message'] ?? "Unknown error occurred";
      throw CustomHttpException(errorMessage);
    } catch (error) {
      print("Error fetching deal promotion types: ${error.toString()}");
      rethrow;
    }
  }

  // void updateField(String key, dynamic value) {
  //   state = state.update(key, value);
  // }

  // Future<void> uploadDeal({required bool saveToDraft}) async {
  //   final url = Uri.parse(
  //       '${baseUrl}/deals/create-edit'); // Replace with your backend URL

  //   // Prepare multipart request
  //   final request = http.MultipartRequest('POST', url);

  //   // Add fields
  //   request.fields['Action'] = "c";
  //   request.fields['DealTypeId'] = state.type!.id.toString();
  //   request.fields['Title'] = state.title.toString();
  //   request.fields['CategoryId'] = state.categoryId.toString();
  //   request.fields['SubCategoryId'] = state.subCategoryId ?? state.subCategory.toString();
  //   request.fields['Description'] = state.description.toString();
  //   request.fields['IsDraft'] = saveToDraft ? "true" : "false";;
  //   request.fields['DealLong'] = dealLong.toString();
  //   request.fields['DealLat'] = dealLat.toString();
  //   request.fields['ShippingId'] = state.shippingFromCountryId.toString();
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