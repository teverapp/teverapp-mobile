import 'package:tever/extensions/auth_status.dart';
import 'package:tever/model/country.dart';

class Auth {
  String authType;
  String? country;
  String? countryFlag;
  String? countryPhoneCode;
  String? countryCode;
  String? email;
  String? phoneNumber;
  String? authToken;
  bool isGuest;

  Auth(
      {required this.country,
      required this.countryFlag,
      required this.countryPhoneCode,
      required this.countryCode,
      required this.email,
      required this.phoneNumber,
      required this.authType,
      required this.authToken,
      required this.isGuest});

  factory Auth.defaultState() {
    return Auth(
        country: Country.defaultState().name,
        countryFlag: Country.defaultState().flag,
        countryPhoneCode: Country.defaultState().phoneCode,
        countryCode: Country.defaultState().countryCode,
        email: null,
        authType: AuthStatus.phone.value,
        phoneNumber: null,
        authToken: null,
        isGuest: false);
  }

  Auth copyWith(
      {String? country,
      String? countryFlag,
      String? countryPhoneCode,
      String? countryCode,
      String? email,
      String? phoneNumber,
      String? authType,
      String? authToken,
      bool? isGuest}) {
    return Auth(
      country: country ?? this.country,
      countryFlag: countryFlag ?? this.countryFlag,
      countryPhoneCode: countryPhoneCode ?? this.countryPhoneCode,
      countryCode: countryCode ?? this.countryCode,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      authType: authType ?? this.authType,
      authToken: authToken ?? this.authToken,
      isGuest: isGuest ?? this.isGuest,
    );
  }
}
