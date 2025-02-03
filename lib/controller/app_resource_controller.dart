import "dart:convert";

import "package:http/http.dart" as http;
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:tever/extensions/deals_tab.dart";
import "package:tever/helpers/general.dart";
import "package:tever/model/app_resource.dart";
import "package:tever/model/common.dart";
import "package:tever/model/coordinate.dart";
import "package:tever/model/custom_http_exception.dart";
import "package:tever/model/predicted_places.dart";

class AppResourceControllerNotifier extends StateNotifier<AppResource> {
  AppResourceControllerNotifier({required this.ref})
      : super(AppResource.defaultState());
  final Ref ref;

  Future<void> fetchResources({required String type, dynamic id}) async {
    print("fetchAppResourceDetailsCategory called");

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
        ? id
        : type == DealsDropList.state.value
            ? id
            : type == DealsDropList.spaceLocationState.value
                ? id
                : type == DealsDropList.dealSubcategories.value
                    ? id
                    : "";

    final url =
        Uri.parse("$baseUrl/util/resource/get").replace(queryParameters: {
      "Page": "1",
      "Limit": "2",
      "Download": "true",
      if (id != null) "ResourceId": resourceId,
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
          fetchedCourierServices: type == DealsDropList.couriers.value
              ? fetchedResources
              : state.fetchedCourierServices,
          fetchedPromotionTypes: type == DealsDropList.promotionTypes.value
              ? fetchedResources
              : state.fetchedPromotionTypes,
          fetchedStates: (type == DealsDropList.state.value ||
                  type == DealsDropList.spaceLocationState.value)
              ? fetchedResources
              : state.fetchedStates,
          fetchedCountries: type == DealsDropList.country.value
              ? fetchedResources
              : state.fetchedCountries,
          fetchedDealDetailsSubCategory:
              type == DealsDropList.dealSubcategories.value
                  ? fetchedResources
                  : state.fetchedDealDetailsSubCategory,
          fetchedDealDetailsCategory: type == DealsDropList.dealCategories.value
              ? fetchedResources
              : state.fetchedDealDetailsCategory,
        );

        print("Updated State: ${state.fetchedDealDetailsCategory}");

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

  void resetFetchedStates() {
    print("reset callled");
    state = state.copyWith(fetchedStates: []);
  }

  void resetFetchedCountries() {
    print("reset callled");
    state = state.copyWith(fetchedCountries: []);
  }

  void addToSubCategoryList({required CommonType subCat}) {
    final updatedSubCatgory = [...state.fetchedDealDetailsSubCategory, subCat];

    state = state.copyWith(fetchedDealDetailsSubCategory: updatedSubCatgory);
  }

  Future<List<PredictedPlaces>> findPlaceAutoCompleteSearch(
      String inputText) async {
    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&key=$mapKey");

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );

      // Decode the response body
      final responseData = jsonDecode(response.body);
      print("Response Data: -> $responseData");

      if (response.statusCode == 200) {
        final placePredictions = responseData["predictions"];

        final placePredictionsList = (placePredictions as List)
            .map((jsonData) => PredictedPlaces.fromJson(jsonData))
            .toList();

        return placePredictionsList;
      }

      throw CustomHttpException("Unknown error occurred");
    } catch (error) {
      print("Error message ->: ${error.toString()}");
      rethrow;
    }
  }

  Future<Coordinate> findPlacesCoordinate(String placeId) async {
    final url = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey");

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );

      // Decode the response body
      final responseData = jsonDecode(response.body);
      print("Response Data: ->>>>>>>> $placeId $responseData");

      if (response.statusCode == 200) {
        Coordinate locationCoordinate = Coordinate();

        locationCoordinate.locationLatiude =
            responseData["result"]["geometry"]["location"]["lat"];

        locationCoordinate.locationName =
            responseData["result"]["formatted_address"];

        locationCoordinate.locationLongitude =
            responseData["result"]["geometry"]["location"]["lng"];

        return locationCoordinate;
      }

      throw CustomHttpException("Unknown error occurred");
    } catch (error) {
      print("Error message ->: ${error.toString()}");
      rethrow;
    }
  }
}

final appResourceProvider =
    StateNotifierProvider<AppResourceControllerNotifier, AppResource>((ref) {
  return AppResourceControllerNotifier(ref: ref);
});
