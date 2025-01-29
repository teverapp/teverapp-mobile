import 'package:tever/model/auth.dart';

extension AuthUpdate on Auth {
  Auth update(String key, dynamic value) {
    print("setting $value");
    switch (key) {
      case 'country':
        return copyWith(country: value);
      case 'countryFlag':
        return copyWith(countryFlag: value);
      case 'countryPhoneCode':
        return copyWith(countryPhoneCode: value);
      case 'countryCode':
        return copyWith(countryCode: value);
      case 'email':
        return copyWith(email: value);
      case "authType":
        return copyWith(authType: value);
      case 'phoneNumber':
        return copyWith(phoneNumber: value);
      case "isGuest":
        return copyWith(isGuest: value);
      default:
        throw Exception("Invalid key: $key");
    }
  }
}
