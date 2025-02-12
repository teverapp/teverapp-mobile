import "dart:convert";
import "dart:io";

import 'package:dio/dio.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:http/http.dart" as http;

import "package:tever/controller/access_token_controller.dart";
import "package:tever/controller/app_resource_controller.dart";
import "package:tever/controller/business_profile.dart";
import "package:tever/controller/user_controller.dart";
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
    final updatedCountries = state.selectedCountries;

    if (index >= 0 && index < updatedCountries!.length) {
      updatedCountries.removeAt(index);
    }

    state = state.copyWith(selectedCountries: updatedCountries);
  }

  void addSelectedStates({required LocationSelection selectedState}) {
    final updatedStates = [...state.selectedStates!, selectedState];

    state = state.copyWith(selectedStates: updatedStates);
  }

  void resetSelectedSubCategory() {
    state = state.copyWith(subCategory: "", subCategoryId: "");
  }

  void resetSelectedStatedAndCountry() {
    ref.read(appResourceProvider.notifier).resetFetchedStates();

    ref.read(appResourceProvider.notifier).resetFetchedCountries();

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
    final updatedStates = state.selectedStates;

    if (index < 0 || index >= updatedStates!.length) {
      return;
    }

    updatedStates.removeAt(index);

    state = state.copyWith(selectedStates: updatedStates);
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
      termsAndPolicy.title = updatedSelectedTermsAndPolicy[existingIndex].title;

      updatedSelectedTermsAndPolicy[existingIndex] = termsAndPolicy;
    } else {
      updatedSelectedTermsAndPolicy.add(termsAndPolicy);
    }

    state =
        state.copyWith(selectedTermsAndPolicy: updatedSelectedTermsAndPolicy);

    return;
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

  void updateField(String key, dynamic value) {
    state = state.update(key, value);
  }

  void printFormData(FormData formData) async {
    Map<String, dynamic> requestData = {};

    for (var field in formData.fields) {
      requestData[field.key] = field.value;
    }

    for (var file in formData.files) {
      requestData[file.key] = "Uploaded file: ${file.value.filename}";
    }

    String formattedJson = JsonEncoder.withIndent('  ').convert(requestData);
    print("Uploading Deal with the following data:\n$formattedJson");
  }

  Future<void> uploadDeal({required bool saveToDraft}) async {
    final token = ref.watch(accessTokenProvider);

    const apiUrl = "$baseUrl/deals/create-edit";

    final creatingBusinessProfile = ref.watch(businessProfileProvider);

    final userData = ref.watch(userDataProvider);

    final hasUserCreatedABusiness = userData.hasCreatedABusiness ?? false;

    try {
      final nonNullDealImages =
          state.dealDetailsImages?.where((file) => file != null).toList() ?? [];

      final dealImageFiles = await Future.wait(nonNullDealImages.map(
        (image) async => await MultipartFile.fromFile(image!.path),
      ));

      // Convert variant images to MultipartFile
      final dealVariants = await Future.wait(state.varient.map((variant) async {
        final nonNullVariantImages =
            variant.images?.where((file) => file != null).toList() ?? [];

        final variantImageFiles = await Future.wait(nonNullVariantImages.map(
          (image) async => await MultipartFile.fromFile(image!.path),
        ));

        return {
          "color": variant.color,
          "size": variant.size,
          "dimension": variant.dimension,
          "material": variant.material,
          "weight": variant.weight,
          "variantImages": variantImageFiles,
        };
      }));

      // Convert Terms and Conditions files
      final dealTnC =
          await Future.wait(state.selectedTermsAndPolicy.map((doc) async {
        return {
          "typeId": doc.id,
          "rawContent": doc.content,
          "rawContentFile": doc.doc != null
              ? await MultipartFile.fromFile(doc.doc!.path)
              : null,
        };
      }));

      FormData formData = FormData.fromMap({
        "action": "c",
        'dealTypeId': state.type!.id.toString(),
        'title': state.title.toString(),
        'categoryId': state.categoryId.toString(),
        'subCategoryId': (state.subCategoryId ?? state.subCategory).toString(),
        'description': state.description.toString(),
        'isDraft': saveToDraft ? "true" : "false",
        if (!hasUserCreatedABusiness)
          'dealLong':
              creatingBusinessProfile.address?.locationLongitude?.toString(),
        if (!hasUserCreatedABusiness)
          'dealLat':
              creatingBusinessProfile.address?.locationLatiude?.toString(),
        'shippingToRegion': state.shippingToRegion.toString(),
        if (!state.contactForQuote) 'price': state.price?.toString(),

        // Deal Details
        'dealDetails': dealVariants,

        // Shipping Details
        'dealShippingDetails': {
          "shippingFromCountryIds": [
            if (state.shippingFromCountryId != null) state.shippingFromCountryId
          ],
          "shippingType": state.shippingToRegion,
          "shippingToContinentIds": [
            if (state.shippingToContinentId != null) state.shippingToContinentId
          ],
          "dealShippingToCountryIds": [
            if (state.shippingToCountryId != null) state.shippingToCountryId,
            ...?state.selectedStates?.map((e) => e.id)
          ],
          "shippingToStates": [
            if (state.shippingToCountryId != null) state.shippingToCountryId,
            ...?state.selectedCountries?.map((e) => e.id)
          ],
          if (state.showShippingRateCard)
            "rate": {
              "courierId": state.shippingRateCourierservice?.id,
              "rate":
                  state.shippingRateCourierservice?.courierShippingRate ?? 0.0,
            }
        },

        // Promotion
        'dealPromotion': {
          "promotionTypeId": state.dealPromotionTypeId,
          "promotionCode": state.dealPromotionCode,
          "promotionValue": state.dealPromotionValue,
          "expiryDate": state.dealPromotionValidDate,
          "requireCheckoutInput":
              state.requiredCustomerToInputCodeDuringCheckOut,
          "hasPromotionalMaterial":
              state.dealPromotionMaterialImage == null ? "false" : "true",
          "isPercentage": state.isPromotionValueAPercentage,
          if (state.dealPromotionMaterialImage != null)
            'promotionalMaterial': await MultipartFile.fromFile(
                state.dealPromotionMaterialImage!.path),
        },

        // Contact Details
        if (!hasUserCreatedABusiness)
          'dealContact': {
            "brandName": creatingBusinessProfile.brandName,
            "about": creatingBusinessProfile.aboutBusiness,
            "contactEmail": creatingBusinessProfile.email,
            "address": creatingBusinessProfile.address?.locationName,
            "longtude": creatingBusinessProfile.address?.locationLongitude,
            "latutude": creatingBusinessProfile.address?.locationLatiude,
            "contactPhone": creatingBusinessProfile.phoneNumber,
            "countryCode": creatingBusinessProfile
                .selectedPhoneNumberCountryDetails?.phoneCode,
          },

        // Terms & Conditions
        'dealTnC': dealTnC,

        // Deal Images
        "dealImages": dealImageFiles,

        // Promotional Material
      });

      // Print out the data being sent before making the request
      formData.fields.forEach((field) {
        print("${field.key}: ${field.value}");
      });

      formData.files.forEach((file) {
        print("${file.key}: ${file.value.filename}");
      });

      printFormData(formData);

      Dio dio = Dio();
      Response response = await dio.post(
        apiUrl,
        data: formData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final createdId = response.data["data"]["id"];

        state = state.copyWith(id: createdId);

        print("Deal uploaded successfully! ID: $createdId");
        return;
      }

      if (response.statusCode == 401 || response.statusCode == 403) {
        await ref.read(accessTokenProvider.notifier).deleteToken();

        throw CustomHttpException("401");
      }

      throw HttpException(
          response.data?["description"] ?? "Unknown error occurred");
    } catch (error) {
      print("Error during deal upload: $error");

      if (error is DioException) {
        print("Dio error: ${error.response?.data}");
        print("Status Code: ${error.response?.statusCode}");
      }

      rethrow;
    }
  }

  Future<void> promoteCreatedDealAsTopPick() async {
    print("pcicc ${state.id}");

    final token = ref.watch(accessTokenProvider);

    // Construct URL with dealId in the path
    final url = Uri.parse("$baseUrl/set/tever-pick/${state.id}");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      final responseData = jsonDecode(response.body);

      print("Complete Profile error res ==> $responseData");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      }

      if (response.statusCode == 401 || response.statusCode == 403) {
        await ref.read(accessTokenProvider.notifier).deleteToken();
        throw CustomHttpException("401");
      }

      final errorMessage = responseData['message'] ??
          responseData['error'] ??
          "Unknown error occurred";

      throw CustomHttpException(errorMessage);
    } catch (error) {
      print("Complete Profile error ==> ${error.toString()}");
      rethrow;
    }
  }
}

final newDealDataProvider =
    StateNotifierProvider<NewDealControllerNotifier, NewDeal>((ref) {
  return NewDealControllerNotifier(ref: ref);
});
