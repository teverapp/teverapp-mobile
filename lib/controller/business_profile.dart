import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tever/controller/access_token_controller.dart';
import 'package:tever/helpers/general.dart';
import 'package:tever/model/business_profile.dart';
import "package:tever/extensions/update_business_profile.dart";
import "package:tever/model/common.dart";
import 'package:tever/model/custom_http_exception.dart';

class BusinessProfileControllerNotifier extends StateNotifier<BusinessProfile> {
  BusinessProfileControllerNotifier({required this.ref})
      : super(BusinessProfile.defaultState());
  final Ref ref;

  void updateBusinessProfile(String key, dynamic value) {
    state = state.update(key, value);
  }

  void addBusinessType({required String businessType}) {
    state = state.copyWith(businessType: businessType);
  }

  void addIndustry({required String industry}) {
    state = state.copyWith(industry: industry);
  }

  void addTwitter({required CommonType twitterUrl}) {
    state = state.copyWith(twitterUrl: twitterUrl);
  }

  void addTiktok({required CommonType tiktokUrl}) {
    state = state.copyWith(tiktokUrl: tiktokUrl);
  }

  void addInstagram({required CommonType instagramUrl}) {
    state = state.copyWith(instagramUrl: instagramUrl);
  }

  void addThreads({required CommonType threadsUrl}) {
    state = state.copyWith(threadsUrl: threadsUrl);
  }

  void faceBookThreads({required CommonType facebookUrl}) {
    state = state.copyWith(facebookUrl: facebookUrl);
  }

  Future<void> createBusinessProfile() async {
    final token = ref.watch(accessTokenProvider);
    print("upload response start ==> ");

    try {
      String apiUrl = "$baseUrl/store/create";

      FormData formData = FormData.fromMap({
        "businessName": state.businessName,
        "brandName": state.brandName,
        "businessTypeId": state.businessTypeId,
        "industryId": state.industryId,
        "businessEmail": state.email,
        "bio": state.aboutBusiness,
        "businessLogo": await MultipartFile.fromFile(state.businessLogo!.path),
        "businessPhone": state.phoneNumber,
        "latitude": state.address!.locationLatiude,
        "longitude": state.address!.locationLongitude,
        "physicalLocation": state.address!.locationName,
        "tikTok": state.tiktokUrl.name,
        "ig": state.instagramUrl.name,
        "fb": state.facebookUrl.name,
        "twitter": state.twitterUrl.name,
        "thread": state.threadsUrl.name,
      });

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

      print("create business response ==> ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      }

      if (response.statusCode == 401 || response.statusCode == 403) {
        await ref.read(accessTokenProvider.notifier).deleteToken();

        throw CustomHttpException("401");
      }
      throw HttpException(
          response.data?["description"] ?? "Unknown error occurred");
    } catch (error) {
      print("Error occurred during business profile creation: $error");

      if (error is DioException) {
        print("Dio error details: ${error.response?.data}");
        print("Dio status code: ${error.response?.statusCode}");
      }

      rethrow; // Rethrow to allow the caller to handle the error
    }
  }
}

final businessProfileProvider =
    StateNotifierProvider<BusinessProfileControllerNotifier, BusinessProfile>(
        (ref) {
  return BusinessProfileControllerNotifier(ref: ref);
});
