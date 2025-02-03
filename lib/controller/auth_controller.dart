import "dart:convert";

import "package:http/http.dart" as http;
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:tever/controller/access_token_controller.dart";
import "package:tever/extensions/auth.dart";
import "package:tever/extensions/auth_status.dart";
import "package:tever/helpers/general.dart";
import "package:tever/model/auth.dart";
import "package:tever/model/custom_http_exception.dart";

class AuthControllerNotifier extends StateNotifier<Auth> {
  AuthControllerNotifier({required this.ref}) : super(Auth.defaultState());
  final Ref ref;

  void updateField(String key, dynamic value) {
    state = state.update(key, value);
  }

  void resetAuthData() {
    state = Auth.defaultState();
  }

  Future<void> signIn(
      {required String userName, required String password}) async {
    final url = Uri.parse("$baseUrl/auth/user/login");

    final requestBody = {"username": userName, "password": password};

    print("signIn resBody $requestBody");

    final jsonBody = jsonEncode(requestBody);

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonBody,
      );

      final responseData = jsonDecode(response.body);

      print("Sign in error res ==> $responseData");

      if (response.statusCode == 200) {
        await ref
            .read(accessTokenProvider.notifier)
            .setToken(responseData["token"]);

        final userData = responseData["user"];

        final hasPassword = userData["hasPassword"] as bool? ?? false;

        final isEmailConfirmed = userData["isEmailConfirmed"] as bool? ?? false;

        final isPhoneConfirmed = userData["isPhoneConfirmed"] as bool? ?? false;

        if (!isEmailConfirmed && AuthStatus.email.value == state.authType) {
          state = state.copyWith(email: userName);

          await sendOnBoardOTP();
          print("has not confirmed email");

          throw CustomHttpException(AuthStatus.hasNotConfirmedEmail.value);
        }

        if (!isPhoneConfirmed && AuthStatus.phone.value == state.authType) {
          state = state.copyWith(phoneNumber: userName);

          await sendOnBoardOTP();
          print("has not confirmed phone number");

          throw CustomHttpException(
              AuthStatus.hasNotConfirmedPhoneNumber.value);
        }

        if (!hasPassword) {
          await sendOnBoardOTP();
          print("has not set password");

          throw CustomHttpException(AuthStatus.hasNotSetPassword.value);
        }

        return;
      }

      final errorMessage = responseData['message'] ??
          responseData['error'] ??
          "Unknown error occurred";

      throw CustomHttpException(errorMessage);
    } catch (error) {
      print("Sign in error ==> ${error.toString()}");
      rethrow;
    }
  }

  Future<void> onBoard() async {
    print("sign up");
    final url = Uri.parse("$baseUrl/auth/user/onboard");

    final requestBody = {
      "phoneNumber":
          AuthStatus.email.value == state.authType ? null : state.phoneNumber,
      "countryCode": AuthStatus.email.value == state.authType
          ? null
          : state.countryPhoneCode,
      "email": AuthStatus.email.value == state.authType ? state.email : null,
      "isTracked": null,
    };

    final jsonBody = jsonEncode(requestBody);

    print("Body==> $jsonBody");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonBody,
      );

      final responseData = jsonDecode(response.body);

      print("sign up response===? ${response.statusCode} body ${responseData}");

      if (response.statusCode == 201) {
        return;
      }

      if (response.statusCode == 400) {
        final hasPassword = responseData["hasPassword"] as bool? ?? false;

        final isEmailConfirmed =
            responseData["isEmailConfirmed"] as bool? ?? false;

        final isPhoneConfirmed =
            responseData["isPhoneConfirmed"] as bool? ?? false;

        print(
            "checking val hasPassword $hasPassword isEmailConfirmed $isEmailConfirmed isPhoneConfirmed $isPhoneConfirmed, type ${state.authType} ${AuthStatus.phone.value}");

        if (!isEmailConfirmed && AuthStatus.email.value == state.authType) {
          print("has not confirmed email ");
          await sendOnBoardOTP();

          throw CustomHttpException(AuthStatus.hasNotConfirmedEmail.value);
        }

        if (!isPhoneConfirmed && AuthStatus.phone.value == state.authType) {
          await sendOnBoardOTP();

          throw CustomHttpException(
              AuthStatus.hasNotConfirmedPhoneNumber.value);
        }
//9037865253
        if (!hasPassword) {
          await sendOnBoardOTP();

          final error = AuthStatus.email.value == state.authType
              ? AuthStatus.hasNotConfirmedEmail.value
              : AuthStatus.hasNotConfirmedPhoneNumber.value;

          throw CustomHttpException(error);
        }
      }

      final errorMessage =
          responseData['error']?['message'] ?? "Unknown error occurred";

      throw CustomHttpException(errorMessage);
    } catch (error) {
      print("onboard erroe $error");
      rethrow;
    }
  }

  Future<void> sendOnBoardOTP() async {
    final queryParams = {
      "phoneemail": AuthStatus.email.value == state.authType
          ? state.email
          : state.phoneNumber,
    };

    final url = Uri.parse("$baseUrl/auth/resend/2FA")
        .replace(queryParameters: queryParams);

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
      );

      final responseData = jsonDecode(response.body);

      print(
          "send onboard otp res ==> statusCode ==>${response.statusCode} ==>query $queryParams data ==> ${responseData}");

      if (response.statusCode == 200) {
        return;
      }

      final errorMessage =
          responseData['error']?['message'] ?? "Unknown error occurred";

      throw CustomHttpException(errorMessage);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> verifyOnBoardOtp(
      {required String otp, required String action}) async {
    print("sign up otp otp $otp");

    final url = Uri.parse("$baseUrl/auth/user/verify-token");

    // final commonRequestBody = {"token": otp};

    // final verifyOtpWithPhoneNumberRequestBody = {
    //   "emailPhone": state.phoneNumber,
    //   "countryCode": state.countryCode,
    //   ...commonRequestBody,
    // };

    // final verifyOtpWithEmailRequestBody = {
    //   "emailPhone": state.email,
    //   ...commonRequestBody,
    // };
//
//
    final requestBody = {
      "emailPhone": AuthStatus.email.value == state.authType
          ? state.email
          : state.phoneNumber,
      "countryCode":
          AuthStatus.email.value == state.authType ? null : state.countryCode,
      "token": otp,
      "action": action
    };

    final jsonBody = jsonEncode(requestBody);

    print("reachedd ==> ${state.phoneNumber} ${state.email}");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonBody,
      );

      final responseData = jsonDecode(response.body);

      print("verify otp res $requestBody $responseData");

      if (response.statusCode == 200) {
        state = state.copyWith(authToken: responseData["data"]["token"]);

        return;
      }

      print("errrororo $requestBody $responseData");

      final errorMessage = responseData['message'] ?? "Unknown error occurred";

      throw CustomHttpException(errorMessage);
    } catch (error) {
      print("errrororo ${error.toString()}");
      rethrow;
    }
  }

  Future<void> forgotResetPassword(
      {required String password, required String confirmPassword}) async {
    final url = Uri.parse("$baseUrl/auth/forgot_password/reset_password");

    final requestBody = {
      "username": AuthStatus.email.value == state.authType
          ? state.email
          : state.phoneNumber,
      "password": password,
      "confirmPassword": confirmPassword
    };

    final jsonBody = jsonEncode(requestBody);

    print(
        "forgot password body token ==> ${state.email} ${state.phoneNumber} $jsonBody");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${state.authToken}',
        },
        body: jsonBody,
      );
      if (response.body.isEmpty) {}
      final responseData = jsonDecode(response.body);

      print("forgot password rersponseData $responseData");

      if (response.statusCode == 200) {
        await ref
            .read(accessTokenProvider.notifier)
            .setToken(state.authToken.toString());

        return;
      }

      final errorMessage =
          responseData['error']?['message'] ?? "Unknown error occurred";

      throw CustomHttpException(errorMessage);
    } catch (error) {
      print("forgot password error ${error.toString()}");
      rethrow;
    }
  }
}

final authProvider = StateNotifierProvider<AuthControllerNotifier, Auth>((ref) {
  return AuthControllerNotifier(ref: ref);
});
