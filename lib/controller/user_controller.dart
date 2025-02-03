import "dart:convert";

import "package:http/http.dart" as http;
import "package:flutter_riverpod/flutter_riverpod.dart";

import "package:tever/controller/access_token_controller.dart";
import "package:tever/extensions/user_update.dart";
import "package:tever/helpers/general.dart";
import "package:tever/model/custom_http_exception.dart";
import "package:tever/model/user.dart";

class UserControllerNotifier extends StateNotifier<User> {
  UserControllerNotifier({required this.ref}) : super(User.defaultState());
  final Ref ref;

  void updateField(String key, dynamic value) {
    state = state.update(key, value);
  }

  Future<void> fetchUserData() async {
    print("fetchUserData called 1");
    final token = ref.watch(accessTokenProvider);

    final url = Uri.parse("$baseUrl/auth/me");

    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );

      final responseData =
          response.body.isNotEmpty ? jsonDecode(response.body) : {};

      print("fetch user data rersponseData ==> $responseData");

      if (response.statusCode == 200) {
        print("fetched user data !!!");

        final userData = User.fromJson(responseData);

        state = userData;
        return;
      }

      if (response.statusCode == 401 || response.statusCode == 403) {
        await ref.read(accessTokenProvider.notifier).deleteToken();

        throw CustomHttpException("401");
      }

      final errorMessage =
          responseData['error']?['message'] ?? "Unknown error occurred";

      throw CustomHttpException(errorMessage);
    } catch (error) {
      print("fetch user data error ${error.toString()}");
      rethrow;
    }
  }

  Future<void> completeProfile(
      {required String firstName,
      required String lastName,
      required String email,
      required String phoneNumber}) async {
    final url = Uri.parse("$baseUrl/auth/user/profile/update");

    final token = ref.watch(accessTokenProvider);

    final requestBody = {
      "bacisDetails": {
        "firstName": firstName,
        "lastName": lastName,
        "long": state.currentAddress!.locationLongitude,
        "lat": state.currentAddress!.locationLatiude,
        "physicalAdd": state.currentAddress!.locationName,
        if (!state.isPhoneNumberVerified!) "phoneNumber": phoneNumber,
        if (!state.isEmailVerified!) "email": email,
      }
    };

    print(
        "complete profile body ==> ${state.isPhoneNumberVerified} ${state.isEmailVerified} $requestBody");

    final jsonBody = jsonEncode(requestBody);

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
        body: jsonBody,
      );

      final responseData = jsonDecode(response.body);

      print("Complete Profile error res ==> $responseData");

      if (response.statusCode == 200) {
        return;
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

  // void completeProfile() {
  //    final upddatedState = state.copyWith(
  //         firstName: firstName,
  //         lastName: lastName,
  //         phoneNumber: phoneNumber,
  //         email: email,
  //       );

  //       state = upddatedState;
  // }
}

final userDataProvider =
    StateNotifierProvider<UserControllerNotifier, User>((ref) {
  return UserControllerNotifier(ref: ref);
});
